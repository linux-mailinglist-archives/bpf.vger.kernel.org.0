Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4B29EEA5
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 15:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgJ2Oo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgJ2Oo2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 10:44:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D896C0613D2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 07:44:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p93so3294875edd.7
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htJryfkjuiAKFHlEy+hEl2GKhIMRmqAYSuUSBMAcs20=;
        b=pkHs+xSH3PMDKxA8AFAFWmQbOqPgMPgdsZXaYjNQPmczG77aNdAxkW7EQDfaYrW6RT
         xLDlz/D79m0uOdWDWldlzMqUMs4KIzH68LEeccwDSM1vvbfhEau8MYohJ/juxXNC0X9r
         67XnhBbkdHus12gcc3VsoZgnqAj9Kn/WAO9iKyBwVt6NacCqtO2bDMmcNwoCvkLyUl2D
         CDx7DHg8wVg25VRF20QM/uQ+RG2PlRKMaFo5mTXls06UX25t53L6RM+I6nuhZonB0ytz
         8dtxsWvc4+rGK/SqqWZfmWlIShS3PbTNWdDPra1uKqVn7ODnKD+DbPDuHXmqDNkyTsGf
         xu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htJryfkjuiAKFHlEy+hEl2GKhIMRmqAYSuUSBMAcs20=;
        b=bV1CUXF2LyUepxmNy0PcqD7wWCIkq3E1DhPfEkV1VxEvmU7+07RSXRy9jQCQpg/b2/
         YBrFxvf8CNWMYc7S+PbcG3n1ZLbAlHXIBB4meYLQKM24TUXcGYNrlZ1EPVQK2CKjMgZE
         fh2+1U32ZGH5Ky/LqkcLHifdkgEifaAmmPLgQc2NvSqKB2gPPE+03J97HSdYyMbJJHpe
         HUIYxo5xBjlK7n2HeFc6//1jwJAFCAcsolS6aypsyBEUvCbfuZfs5uvzHWGRCtcqrzhl
         KZpP8lIfhWj7EKPKyEZBmwuM5OWrbIOo4cKvsuEncCGjLDZRc1wElKlsWCp9ZcJ6yxhC
         +UrQ==
X-Gm-Message-State: AOAM533pfb/o5i6+B6CE58VKdXG1TmFMdxzH8JR2ECTCGFzYyFa3WSpO
        r93h3hDeeU/YZxBPR52SHV6Gan0lo90+rWx1eL0FS6Nd2uRzWogR
X-Google-Smtp-Source: ABdhPJzUSomkNT8XyMbXwvlAc2Dv4y1Gt8TF/7nNLimNlwPv+JSZYrBfqTctMs/H1Pifh5Fv4JKzleXcRbySm/ZSEio=
X-Received: by 2002:a50:da8b:: with SMTP id q11mr1647515edj.73.1603982666878;
 Thu, 29 Oct 2020 07:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201023123754.30304-1-david.verbeiren@tessares.net>
 <20201027221324.27894-1-david.verbeiren@tessares.net> <CAEf4Bzb84+Uv1dZa6WE5Eow3tovFqL+FpP8QfGP0C-QQj1JDTw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb84+Uv1dZa6WE5Eow3tovFqL+FpP8QfGP0C-QQj1JDTw@mail.gmail.com>
From:   David Verbeiren <david.verbeiren@tessares.net>
Date:   Thu, 29 Oct 2020 15:44:10 +0100
Message-ID: <CAHzPrnEfDLZ6McM+OMBMPiJ1AT9JZta1eognnnowbtT9_pHGMw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: zero-fill re-used per-cpu map element
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 11:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> Looks good, but would be good to have a unit test (see below). Maybe
> in a follow up.

Here is the associated new selftest, implementing the sequence you
proposed (thanks for that!), and also one for LRU case:
https://lore.kernel.org/bpf/20201029111730.6881-1-david.verbeiren@tessares.net/

I hope I did it in the "right" framework of the day.
