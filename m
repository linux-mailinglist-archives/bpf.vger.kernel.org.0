Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8D634E41
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 04:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiKWDSx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 22:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiKWDSw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 22:18:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075A58D4AC
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 19:18:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso692970pjq.5
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 19:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeT+8QNGGHYZzyItAjDLKvUg5YuzowaTq2pC5CnMqYw=;
        b=QOqHJoRb8JlU/FiZh/40ZqizVxdRuMbLR5Gc0mzIvWBUmSnXdolpTcSqChA0+JM6++
         jfjIdbaRS0I8Mm1SziEDnr3K401WtJrl1TDLKDDCnuRnqHLlL1du7/ZJG7w26aPJI4H4
         lzc6UHLqYWYOE5v7dUU9XiQXwQy7SLgKwCBBLrN4/zl4PPYwvBQDJCjhAAeRaQPnEYqT
         +ijfSHePOm1Nr+5jAN4jeSXTGHItCglwaXfuSX7x/X1ZRi8gmo6Jem2sMfNqKFCTpKEL
         fqIeJn6FLGm4EUAwDSEhrAVBKWqi1o9IeTIO9oE73r85w54qTjdAWj0ez55WpQ0RMZKO
         yCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KeT+8QNGGHYZzyItAjDLKvUg5YuzowaTq2pC5CnMqYw=;
        b=fJ1YHAHbXh8NEWsjjsKpMtvK3rr7DXFhFp9qRmc5NZD3lKmVLUBCIt7TKg386Ke8uj
         H1VMsko75p31RIdB/aHdbIeDgNVE6QdwXWr33NkZtUL7bxmXSHOJHW87n/79uxBISytQ
         vx/uM1SGJRav2J+P8aWKEh+VRzgevhO7c619MHh+Exjxu0/welim0hsBq6He00jZ8Dnn
         Y2THX0UsnmYCWUTZutENFd+43eutqbrJK6ytXNGfqP0yhsiAsuRkckb3hPOdT36Fe3YA
         3Gs1YgaCazQ7RYN+ZI7Hy+t2lMRB5Bsi0mXOIT3G5af596VHQqeWtk1jdYP/L2ZhSTFP
         rOsQ==
X-Gm-Message-State: ANoB5pmiE7eAifwGtRFoba9/2tRMf/UaiPbD8+CZ0cufJ+nVbbsK5MYN
        ReBUaVFYBYOH2o/GhOJughc=
X-Google-Smtp-Source: AA0mqf633+1RAJCK8Hc6AbJzYp5z+ku/V7oOCFnKmZ1lhMZEJvpEf28lqZ/UsEHroB3Sv9/9UNRzmQ==
X-Received: by 2002:a17:902:b908:b0:189:1ef4:237b with SMTP id bf8-20020a170902b90800b001891ef4237bmr7364921plb.20.1669173530456;
        Tue, 22 Nov 2022 19:18:50 -0800 (PST)
Received: from localhost ([129.95.226.125])
        by smtp.gmail.com with ESMTPSA id a28-20020aa795bc000000b0056beae3dee2sm11770397pfk.145.2022.11.22.19.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 19:18:49 -0800 (PST)
Date:   Tue, 22 Nov 2022 19:18:49 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <ast@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <637d911914799_2b649208da@john.notmuch>
In-Reply-To: <e727f852-7484-b31f-fb5d-7a4f034fe48e@meta.com>
References: <20221120195421.3112414-1-yhs@fb.com>
 <637ade2851bc6_99c62086@john.notmuch>
 <2c4f8cac-6935-2c72-cc1b-34a34708e127@meta.com>
 <637c2a6c4b042_18ed92085f@john.notmuch>
 <e727f852-7484-b31f-fb5d-7a4f034fe48e@meta.com>
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On 11/21/22 5:48 PM, John Fastabend wrote:
> > Yonghong Song wrote:
> >>
> >>
> >> On 11/20/22 6:10 PM, John Fastabend wrote:
> >>> Yonghong Song wrote:
> >>>> Currenty, a non-tracing bpf program typically has a single 'context' argument
> >>>> with predefined uapi struct type. Following these uapi struct, user is able
> >>>> to access other fields defined in uapi header. Inside the kernel, the
> >>>> user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
> >>>> in short) which can access more information than what uapi header provides.
> >>>> To access other info not in uapi header, people typically do two things:
> >>>>     (1). extend uapi to access more fields rooted from 'context'.
> >>>>     (2). use bpf_probe_read_kernl() helper to read particular field based on
> >>>>       kctx.
> > 
> > [...]
> > 
> >>>   From myside this allows us to pull in the dev info and from that get
> >>> netns so fixes a gap we had to split into a kprobe + xdp.
> >>>
> >>> If we can get a pointer to the recv queue then with a few reads we
> >>> get the hash, vlan, etc. (see timestapm thread)
> >>
> >> Thanks, John. Glad to see it is useful.
> >>
> >>>
> >>> And then last bit is if we can get a ptr to the net ns list, plus
> >>
> >> Unfortunately, currently vmlinux btf does not have non-percpu global
> >> variables, so net_namespace_list is not available to bpf programs.
> >> But I think we could do the following with a little bit user space
> >> initial involvement as a workaround.
> > 
> > What would you think of another kfunc, bpf_get_global_var() to fetch
> > the global reference and cast it with a type? I think even if you
> > had it in BTF you would still need some sort of helper otherwise
> > how would you know what scope of the var should be and get it
> > correct in type checker as a TRUSTED arg? I think for my use case
> > UNTRUSTED is find, seeing we do it with probe_reads already, but
> > getting a TRUSTED arg seems nicer given it can be known correct
> > from kernel side.
> > 
> > I was thinking something like,
> > 
> >    struct net *head = bpf_get_global_var(net_namespace_list,
> > 				bpf_core_type_id_kernel(struct *net));
> 
> We cannot do this as ptr_trusted, since it's an unknown cast.

I think you _could_ do it if the kfunc new to check the case type
and knew that net_namespace_list should return that specific global.
The verifier would special code that var and type.

> The verifier cannot trust bpf prog to do the right thing.
> But we can enable this buy adding export_symbol_gpl global vars to BTF.
> Then they will be trusted and their types correct.
> Pretty much like per-cpu variables.
> 

Yep this is the more generic way and sounds better to me. Anyone
working on adding the global var to BTF now?

Thanks,
John
