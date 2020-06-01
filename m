Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82491EB017
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 22:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgFAUSI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 16:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbgFAUSH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 16:18:07 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 693312076B;
        Mon,  1 Jun 2020 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591042686;
        bh=gTxHNUn+c76zemOeMmtcdzx9uVaCHcJ5E/m8Bh3yCOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tr0RQWR6oS6AssPXqfmeq9xuvj7d9qQdiRkCMfNRT8f863omNQQQ2qQyRZ8vm7t1D
         rch1yJSLWyZrBmgTyZjcbBNVWJ7hipC9qOlpLIdgK/DkatV8GES6dxiLZJ/hTmhRI1
         rqj3JlCgX/JZtZLpuG+rsFrE9Ii/CzYzflWPHbuk=
Received: by mail-lj1-f182.google.com with SMTP id m18so9788390ljo.5;
        Mon, 01 Jun 2020 13:18:06 -0700 (PDT)
X-Gm-Message-State: AOAM530bHzQY8XD2MiWIKcVsPjzAJMSHNk5FXCECBMQdyyu/vynKu7r5
        iEBZvMRaa8Xy9QR6C6/XmdZCyUoAEpGAQ6XQxJs=
X-Google-Smtp-Source: ABdhPJwvioT6Tk2rGCLM59ZIXtwMkm6KmKCoUrFB2IhhLJ5TIjz3MFr0H1zBt+czuJOum20rxlt+BKbayd1hZA5ABgI=
X-Received: by 2002:a2e:9115:: with SMTP id m21mr763659ljg.350.1591042684664;
 Mon, 01 Jun 2020 13:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200601162814.17426-1-efremov@linux.com>
In-Reply-To: <20200601162814.17426-1-efremov@linux.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 1 Jun 2020 13:17:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4nHJ6ewZ6U6EyJYUx7AFpde5D38yRykK3Q_cGf7sgBaQ@mail.gmail.com>
Message-ID: <CAPhsuW4nHJ6ewZ6U6EyJYUx7AFpde5D38yRykK3Q_cGf7sgBaQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Change kvfree to kfree in generic_map_lookup_batch()
To:     Denis Efremov <efremov@linux.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 1, 2020 at 9:29 AM Denis Efremov <efremov@linux.com> wrote:
>
> buf_prevkey in generic_map_lookup_batch() is allocated with
> kmalloc(). It's safe to free it with kfree().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Please add prefix "PATCH bpf" or "PATCH bpf-next" to indicate which
tree this should
apply to. This one looks more like for bpf-next, as current code still
works. For patches
to bpf-next, we should wait after the merge window.

Also, maybe add:

Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")

Acked-by: Song Liu <songliubraving@fb.com>

Thanks,
Song
