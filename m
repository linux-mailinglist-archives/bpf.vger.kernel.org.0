Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE31395B5
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2020 17:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgAMQWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 11:22:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43380 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAMQWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 11:22:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so8752018oif.10
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=XpTxTKPtBT+Nqvx/G+T/EX/Ex7qtAtXUan1F+Ou5AaU=;
        b=jew6pjB115uflGMdVoUhrQfGirNScNaByLv6zEM0QkiS1fkVURN1uoaqu+QvIRlLwE
         tJLjdEWE6AmqtrD055UYcZ3iNyZak6BoFpS9C/zPQ+DL94Sgg3QeITM7g1syBjlnaFSa
         blOAFjBZ7erzl4iqiBY0MhhuFgbNaEbFY7Ov5KEvfBOPTTFjckCH3PPfOxwMprWXK8/f
         AajuP5gwvLLtAuPaMoS7PSe5CRJUBU6nTnk5NlTeKtO/b99GB+ZCtXzyCDZ11n0f5vHP
         MfY7N9fj9z6QhV+dvfLayGRGU6/pQTgka5Yl2S+p/mUuZMUf3hnxLF5KKgb6gqj1zj9b
         uBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=XpTxTKPtBT+Nqvx/G+T/EX/Ex7qtAtXUan1F+Ou5AaU=;
        b=VtjB1by/MPJjGDgV5wYQ48mVLPd1qm/Cf1lMCqGYrpMHitbPuQLCxUzC4dYOOQe+gc
         Lb8FENySSHdznjxOzQzIINTJGifjdc2/UxPg8EXkRvkIK820779W+R4EYKmSPpWoeZgk
         UZL/MZRZk1m9A3CI+G8q+Ob6HbhQjFXlBFo0Oei+EetpDuLkQjjUqdd4rKbrj0rfMJ4p
         B1MuahvFnW/SF5p9Uf9lOmaope+GiaTzyNJrkFPzUjgHAoIP2IVL8vEENF6uaT1EuSoM
         HHL6+bCtpBKG1V0YuJpgQAq7yUsQJdj+Hhoq+nu4+nTFKM7Mt+Gm/x7nE3Wcsq9bzaGi
         KeFA==
X-Gm-Message-State: APjAAAXoQRJQHyDVgxpSQfXbXCoO9JiuI1dD35HPoZHft8StVBlk9LvD
        smliKSvAiKufe5mnRKYru41JmqekwRLzqo/hJgc=
X-Google-Smtp-Source: APXvYqwt6uDw9SA1bDGFDNtFHAigN4CWes3zwYK3cP5+KqtCtR7MLre5a2X7pO1Ibb3UgL9gSCmEpHw26cI3sA1/GhA=
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr12576279oih.106.1578932542720;
 Mon, 13 Jan 2020 08:22:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:6491:0:0:0:0:0 with HTTP; Mon, 13 Jan 2020 08:22:22
 -0800 (PST)
Reply-To: miraclegod913@gmail.com
In-Reply-To: <CAO5FVPc19H+2mL5z9yHM+W=dEoRnUySty_+QN577u_Kk21ZXMQ@mail.gmail.com>
References: <CAO5FVPeEU2cUcYkfZVKYcy_CR1G63=-FGEKD07hsS+bkKGbBEg@mail.gmail.com>
 <CAO5FVPc19H+2mL5z9yHM+W=dEoRnUySty_+QN577u_Kk21ZXMQ@mail.gmail.com>
From:   Christy Ruth Walton <miraclegod13@gmail.com>
Date:   Mon, 13 Jan 2020 08:22:22 -0800
Message-ID: <CAO5FVPd8ApE+f_B9rES7MSKztmq-EViN3Uiog62=L55tVLBxnQ@mail.gmail.com>
Subject: Fwd: Christy from America.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I want to open Charity Foundation in your country on your behalf is it okay?

My Regards,

Christy Ruth Walton from America.
