Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2688620387
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiKGXOE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiKGXOE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:14:04 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D32664
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:14:03 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id k15so12219665pfg.2
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HLlunmUStZdjxgANW5M/a33WLS9fq9JydFb2GI0nRU=;
        b=m8UOOxneKOQ0N2xJ0Kv5WwSWBQWi7AZjhapKwWR56eq3LDbVEOmKE2n/zNlh1yQY/c
         KPIVHvPsIGB84w0iR196+uCbt5sYCcHwWEu58tjtYH5JCGDY3y/Y2KkU+QyHZCxAeILX
         +oNg4RYD7xCAjjUqh6IaQ4EyuFnRPC39gmFbn8Cauxel3mhUEdBq4O96ExkCs20ACZqZ
         tDA55YMWz14ffr0QZkLzvxQrYOZjaFS3uxhfsVAs//gRbjkT9uOJuA/88V1kndZqt8C3
         BWy6SoJHSXe3llpx/FqKubLlgYoq0mIBvOnpnWyXn4Y0YViKNlNIPK6ZiGoUSjwmTx4T
         Giaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HLlunmUStZdjxgANW5M/a33WLS9fq9JydFb2GI0nRU=;
        b=3ZqrKrPylQk+OgpHRwNe7tHTxmhHCIuGelv5lWpnyVYPchHJmlb0K1YSoyviW5948c
         eiuwrGJzSsIziARF0fulsk7CzoEJV6ct4R4A8KqtZxWF4Ohejr//zYf/Tgb8Xc0xAoap
         C/9ik0uvVzXrE5nGz82JN1H4iL5Jitld9VglyRYsToLNd0u0zNBXQ4rcMrtbCNI/Cug7
         favN/LBYzogXJfR64fJjHJDMrNU6ezZrYgRUyICRANJopIBVzycbcwG5IBDt4YtYrHlu
         W00huc7N92/V4r2W6ZmKfkuBGzKM9L5AxvnsZM8wEHzBjhV0ystrgaG3HnHL+HKrxhEB
         Bqvg==
X-Gm-Message-State: ACrzQf1F+M+1+dkFGCmHdSfXlGIEURHNOZyg68UTuIJy9dGkKFNnXMxh
        eHYntAWsLdW6T2e9dqOZ50RqRLJ9cWd29Q==
X-Google-Smtp-Source: AMsMyM7AZNfLkEzDAPDOYohWxQNeQ1VLpEXAGteOBzM/O70JBUeyl6Pj2pw7OLOwgAEa3lrQ+xlgdw==
X-Received: by 2002:a05:6a00:1a89:b0:56d:ba11:9f25 with SMTP id e9-20020a056a001a8900b0056dba119f25mr38319300pfv.10.1667862842891;
        Mon, 07 Nov 2022 15:14:02 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b00179f370dbe7sm5427829plh.287.2022.11.07.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:14:02 -0800 (PST)
Date:   Tue, 8 Nov 2022 04:43:56 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH RFC bpf-next v1 1/2] bpf: Fix deadlock for bpf_timer's
 spinlock
Message-ID: <20221107231356.qaotvqi7dgojacly@apollo>
References: <20221106015152.2556188-1-memxor@gmail.com>
 <20221106015152.2556188-2-memxor@gmail.com>
 <CAADnVQ+iuB6abH0=N0su6DGAW1FnOtgUQ+Zq6x9bH1w5X_6P=w@mail.gmail.com>
 <20221106214444.nbqh4qdpsoaj5t7s@apollo>
 <CAADnVQLiPdCZSiGsy7rUWttpM+iuXp+2BJoaHqR_ajc4K-xuWw@mail.gmail.com>
 <20221107014851.fofi3xxqlludjgez@apollo>
 <CAADnVQKyUKeEs14uzcHKym3iVtjV1DU2HkitPc+NvV8RUZW=Pg@mail.gmail.com>
 <CAADnVQKGd20kh_4xcEFMi365bOt0KtDwkYnzZsZP=vioVX3mGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKGd20kh_4xcEFMi365bOt0KtDwkYnzZsZP=vioVX3mGw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 07, 2022 at 09:15:26AM IST, Alexei Starovoitov wrote:
> On Sun, Nov 6, 2022 at 6:34 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > >
> > > For bpf_timer, it would mean moving drop_prog_refcnt outside spin lock critical
> > > section. hrtimer_cancel is already done after the unlock. For bpf_list_head, it
>
> > > would mean swapping out the list_head and then draining it outside the lock.
> >
> > That also works.
> > drop_prog_refcnt() can be moved after unlock.
> > Don't see any race.
>
> I mean not the whole function obviously.
> Instead of
> static void drop_prog_refcnt(struct bpf_hrtimer *t)
> it can become
> static struct bpf_prog *drop_prog_refcnt(struct bpf_hrtimer *t)
> t->prog and callback_fn should only be manipulated
> under lock.
> bpf_prog_put itself can happen after unlock.

Right, both t->prog and t->callback_fn need to be set to NULL under the lock.

I will send out the bpf_timer change separately. For now, I moved list draining
out of the lock in my series and removed the check on BPF_PROG_TYPE_TRACING, and
posted it.
