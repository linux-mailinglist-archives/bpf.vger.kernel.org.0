Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4852B2DB89A
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 02:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgLPBqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 20:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLPBqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 20:46:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51B7C061793
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 17:45:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a12so44386667lfl.6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 17:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ud5g5Z31pXBXli7/pFB+vBHBYWkXaanPdiS51GXPzvE=;
        b=EVQdRAj3wWWo+LpgedFskAHSzdfNTzHf/NIUvQddquniKKnNrouzkzsOvpK6uE5D8L
         zDoGa0orB8PLCvLCPKXVlfd6uZhM8kl72FetWleRL1hOYnAjexG/E7r8gIhhyyN/aZm/
         Bol9SPCKnydIS7EMv8hcyx8MJy4bFD6dURLQm7TXIWfayGLuniLXV2TgOKJCOEiSqovD
         LCtE+uCvD92K45EgodYtuqs3/A9xzHVKRq3eTbi8kCPF5UNx1/php5/DizWS2SGDDXfL
         SZEba92o4JLFAvJT0c7wHICw20zTxOAaBsmyz3LTt92wU/bAhGEC/vufnGQSNStW3WnV
         Thww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ud5g5Z31pXBXli7/pFB+vBHBYWkXaanPdiS51GXPzvE=;
        b=ZhLKIqfxLK8p6LX3iolCOOsf8E/Ky0pYMURfntxrW2HZMmHO5kF9/3axzdd6Mo5qb2
         4E9qWR/234+P7i8FSkov0lqxXU6owvVrpsFKcepULt/fDVT7aPgftmK0BUaYDzVxGQoG
         Mt7G+RlbRzkmU6tjXtQHw1No7cGfj1/JK0fSqFAd/3F4O9fp1GqZfRBbxwPGNSR7ByOF
         7k5ESiC5z7blomnzwdI/gbbJPx2nzc7qyo35hIFI5yjAKkfb5zOXjLCc6mgcHiUtzR7S
         senvISwk+awVPq81KsW6fkwpFMZUknPS4heJXYS4UlbtKFm/cYO7/+iJw4n6w2SxCh8p
         Vdfg==
X-Gm-Message-State: AOAM532Ujk+U35mvR/rW4wcD+ElIeF2UpJS7+o6oeExTu76rR2XAd2LX
        o6MMN0KyRl64yFjuDDjPV37THQckqTme5euOoG4=
X-Google-Smtp-Source: ABdhPJzigqYfFNBg0I2mH1am0DR6Yd5Wxv1+6grW/8+adV1bLg7EhfnS/SM06Ijk5z3GgwOKSipQe7hE4/2Ozezdoiw=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr1891272ljj.32.1608083157718;
 Tue, 15 Dec 2020 17:45:57 -0800 (PST)
MIME-Version: 1.0
References: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
In-Reply-To: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Dec 2020 17:45:46 -0800
Message-ID: <CAADnVQJOCGQanyw2qfG4gxEw3FHQ0oSUbSeAk2WTuZ+mnwVk5Q@mail.gmail.com>
Subject: Re: Why n_buckets is at least max_entries?
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 1:44 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Hello,
>
> Any reason why we allocate at least max_entries of buckets of a hash map?
>
>  466
>  467         /* hash table size must be power of 2 */
>  468         htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);

because hashmap performance matters a lot.
