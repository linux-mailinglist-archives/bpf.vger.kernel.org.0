Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857BD215F1F
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgGFS7Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 14:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFS7Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 14:59:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB8C061755
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 11:59:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so40390946wmi.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bt4u4JPMznhkNHKuGAbh472Qnx6WWkHIy3F9uekLf+M=;
        b=bN7YWShsuTBQnAjnEvGtGV989roN3XzZ/8UZTlJpfS2ieB4DV66lNQpKQlLzLCE8Oz
         BN4Tqqrs6qlg0q1KkFjIpmPfP5rfnWU29ZMDyMbftJ86Dv25JtPBLCbNd1DSu4w+MWcL
         kpTleCHfPrmNBtMaLpXqNKlUPauo3CJ8ewEa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bt4u4JPMznhkNHKuGAbh472Qnx6WWkHIy3F9uekLf+M=;
        b=V7Xjr79oc8k2PGkarZU8i7NYSY+OXm4Yqip/oAAXiNIss0qHuk68LuK/Sece7pOshP
         Wqp//V1e8HnY//+8NsYPJT4Vg9kFV0x2alr4QTXVfYL89DDDXZZ29MAQN12VRnkav9tX
         TQgf98kidprCxVwfPlfLzjtXPtuYBFN9TEdvfA3eUsZ3/u2NxJu675U1cLQ+W1P6edrP
         WGiHj9YUkuHae+fHfDsVrtNzKrVWHKyejTIjaFa6oXByK1UFnZb2Lng2o/QMdl+Ckyx0
         xSPsFH41mzA2sJrYNFMqgwZLQTIVAFVyjJHR6y2IKResay0oDRvPVkVl7FB0n8ZPS0TV
         2hIg==
X-Gm-Message-State: AOAM5315s/NOBAg/KlJznQi/yY22+dR7gpQJ6jAnhE9+YkwBgHDxkYon
        bwFkJ7Z8qKhowgZHwYvVqVubgItaTJx0Rk4k8zEXbg==
X-Google-Smtp-Source: ABdhPJx/T88NRzDryjebsL1qpMHu22FFGmE2YItlZrMwdnQZXDcqA5JLarOoawNn6U1/M3a712v484b54U5lQm70yek=
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr566989wml.170.1594061963644;
 Mon, 06 Jul 2020 11:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200706165710.GA208695@gallifrey> <9268bd47-93db-1591-e224-8d3da333636e@iogearbox.net>
In-Reply-To: <9268bd47-93db-1591-e224-8d3da333636e@iogearbox.net>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 6 Jul 2020 20:59:13 +0200
Message-ID: <CACYkzJ78HOP8SZ3jU0DnH0b4f8580AuP4fdG5K3xgaHa8VYaZw@mail.gmail.com>
Subject: Re: [PATCH] bpf: lsm: Disable or enable BPF LSM at boot time
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Lorenzo Fontana <fontanalorenz@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 6, 2020 at 8:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/6/20 6:57 PM, Lorenzo Fontana wrote:
> > This option adds a kernel parameter 'bpf_lsm',
> > which allows the BPF LSM to be disabled at boot.
> > The purpose of this option is to allow a single kernel
> > image to be distributed with the BPF LSM built in,
> > but not necessarily enabled.
> >
> > Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
>
> Well, this explains what the patch is doing but not *why* you need it exactly.
> Please explain your concrete use-case for this patch.

Also, this patch is not really needed as it can already be done with the current
kernel parameters.

LSMs can be enabled on the command line
with the lsm= parameter. So you can just pass lsm="selinux,capabilities" etc
and not pass "bpf" and it will disable the BPF_LSM.

- KP

>
> Thanks,
> Daniel
