Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89FF15BC68
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2020 11:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgBMKMa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Feb 2020 05:12:30 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38399 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKMa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Feb 2020 05:12:30 -0500
Received: by mail-wm1-f50.google.com with SMTP id a9so5940859wmj.3
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2020 02:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=user-agent:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOsZ3DKvBArWpdGGSe8+H9SszvUwbLK31SaMjq5y6EM=;
        b=JxPVNnhY8sWqssEyaVgye0MX8yOa6yVfJT417asld0HmgYHefWZD9shljmmB5rhKOR
         Vrf1/8PR+FXNw6B651xNe5R3xCtkTFHfWGGI02qkAeFII9uic9a7CDiGBoNMWKfKKplV
         l6giA0ezzuH2wsDV5WVCyPI8g4RuvjrkzoNmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nOsZ3DKvBArWpdGGSe8+H9SszvUwbLK31SaMjq5y6EM=;
        b=P9gWx9aqgX46ohMzHZBGJH/MwwULAUjdyinZ6nHUN9BVPahyb7bqVzAhlPkO7BWsSI
         TVLh+RMoNQPfjizj36lTaCsAu2ufHkR4UOZf+4OfyH5Bmx8COpLKvAwjvDuG41BRNydu
         Ok5rlIHsm6VVEEc0qjeF0kwoLprG7X8hTvA5txfMIniiby7yVq1PKe9+1R5tnkEAUc1i
         SeRiPNLkU18H6fUO0qBJMIJ99MWrOJ4r9dJmfb5vKQSfS+ce/Hg8b32PsQtaTC0U7U0V
         TPVVLRC3icI5xvVbdnQBmg2U2JqBSSnP2Vfg8olzGrOyvlDKARySE3v4acEIBvurtF9M
         jhyA==
X-Gm-Message-State: APjAAAWr+8QcAGmQnnYCEQgAoogdilYNqyGpF8Nuev2UxKlTN3SUPlWP
        Pou94YS5EvlV6+iXoBNwwl7/CvmvF8TDdzkB
X-Google-Smtp-Source: APXvYqxix9cVp2Er/fUVjaVPTNEhhC0KL5MXHeoA001S0VIVXLJ4cPx8Ay+bpFCXZqw2q5MqmrH8ew==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr5297312wmc.185.1581588748022;
        Thu, 13 Feb 2020 02:12:28 -0800 (PST)
Received: from cloudflare.com ([88.157.168.82])
        by smtp.gmail.com with ESMTPSA id m3sm2332260wrs.53.2020.02.13.02.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 02:12:27 -0800 (PST)
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>
Subject: Extending sockmap and future of L7 BPF framework
Date:   Thu, 13 Feb 2020 10:12:26 +0000
Message-ID: <878sl6aj91.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extending sockmap and future of L7 BPF framework
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

At Plumbers =E2=80=9819 we presented our plan to make socket dispatch
programmable using BPF [0]. A key component is the ability to look up
sockets from a map. Our proof-of-concept patch-set used the sockarray
map designed for reuseport BPF programs. Based on feedback from the
community we=E2=80=99re doing work to transition to sockmap and sockhash.

Specifically, we are adding support for TCP sockets in TCP_LISTEN state
and UDP sockets in general. Additionally, we=E2=80=99ll let the reuseport B=
PF
use sockmap and sockhash in addition to sockarray.

We propose giving an overview of this work, and the user-space and BPF
API changes it entails. This work brings up questions revolving around
the future of L7 BPF frameworks and how it should evolve that we would
like to discuss:

- Should sockmap be extended further to hold sockets in any state?
  Would this make the user-experience better?

- How to make sockmap and sockarray gracefully share sk_user_data,
  i.e. the link from the sock object to the map?

- Is there a potential for code sharing between sockmap and sockarray?
  Would that make maintenance easier?

- How should API redirecting to UDP sockets with sockmap look like,
  considering use of connected UDP sockets is not recommended?

- Can we have a common helper for map-based redirect that works with all
  map types that can hold sockets, i.e. sockmap, sockhash, and
  sockarray?

[0] https://www.youtube.com/watch?v=3DqRDoUpqvYjY
