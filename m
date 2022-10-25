Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AD60D30D
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiJYSMB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiJYSMA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5228C9080D
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:11:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so8033909pjj.0
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy/eNa0vbcc3yeY3v3OXAal9G9u+OEzWLIqHexkf77U=;
        b=OQBhGRUQe4Y/D5E/8TJevhoJOUNudQ3cIoZoFf7Yip62HkUz5cqSIOzYWuqMNu9NHQ
         NY3Z1263jWv90oqOR7r7UlrjDBAyxIfduoibp6F3yYi+VtgPqgJL01n3+xrXGwWoeSCr
         wZ85alZJhzwlKfHpvervvomWmOBd1kUPpt7Fbbwxgbe8Ie2LxS4jrONKvjgMsNQxwFHG
         YZrUsQeztq+wxAWTOucYbRXYOYpBusv1VFE1dB6rDUFWme2c02VshD8Vv2y2YTwLiO6W
         aV7qyWXaJEiU7hXFc2PVGrJscbAJC3lZXm/vm5g+55yRrE0Ijyi6HLTKNaOHv1OmtQL1
         SGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy/eNa0vbcc3yeY3v3OXAal9G9u+OEzWLIqHexkf77U=;
        b=4eF8dAxGOkE9G5SGkuQ6TqU8HjNRQ/5sgCH8r4sR9L4idPp8YpaDMqrJFCUEEjcxKP
         QNuvfIifKuXkUIiHBmGk4X5bZslj2SRvu9Il7ziXpArvzpxe/drgxFBkO5vnPRJ4y6sm
         NUer7K6ENJETifJoZATZ2jaB3Q7lDp9hAJxIhsDUq2a60FfcjmiUrBIkhZHWzQxFfYMV
         mFj0olgHpObxVBJJTxrJhFu8PDAJJeBSZKzMpORRXuPyKcQ3R1Ag6R8WW3gcAZC0Z5DY
         h00OvV+z6j3WO2PZXHW560lnDB9QzXVklA32pqEdMX21t95cd+OK6D9hL3lJzbXbv8oD
         EQAQ==
X-Gm-Message-State: ACrzQf15rnZ9PpfaBTzBXkwVIHmVSfXucDERwf27vIXfUhK6LG+xEFEv
        TrryobCECh5+saVdtietTr7B6g7Ax86V0g==
X-Google-Smtp-Source: AMsMyM7lK1ueY60+NctaAgJ+Ay8tNr3O9/n+0FX12qEW+MN49jwB/mrtDwzGJRKvMXDMe6bL6rJcPg==
X-Received: by 2002:a17:90b:4d05:b0:202:ec78:9d73 with SMTP id mw5-20020a17090b4d0500b00202ec789d73mr46019396pjb.103.1666721518713;
        Tue, 25 Oct 2022 11:11:58 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7940b000000b0056be7ac5261sm1646639pfo.163.2022.10.25.11.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:11:58 -0700 (PDT)
Date:   Tue, 25 Oct 2022 23:41:57 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 10/25] bpf: Introduce local kptrs
Message-ID: <20221025181157.lx2idthc5zdoclg7@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-11-memxor@gmail.com>
 <bf1c4d27-e2e0-2309-d2eb-f83e5a387adf@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1c4d27-e2e0-2309-d2eb-f83e5a387adf@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 25, 2022 at 10:02:49PM IST, Dave Marchevsky wrote:
> On 10/13/22 2:22 AM, Kumar Kartikeya Dwivedi wrote:
> > Introduce the idea of local kptrs, i.e. PTR_TO_BTF_ID that point to a
> > type in program BTF. This is indicated by the presence of MEM_TYPE_LOCAL
> > type tag in reg->type to avoid having to check btf_is_kernel when trying
> > to match argument types in helpers.
> >
> > For now, these local kptrs will always be referenced in verifier
> > context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> > to such objects, as long fields that are special are not touched
> > (support for which will be added in subsequent patches).
> >
> > No PROBE_MEM handling is hence done since they can never be in an
> > undefined state, and their lifetime will always be valid.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> One nit unrelated to the other thread we have going for this patch.
>
> [...]
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 066984d73a8b..65f444405d9c 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6019,11 +6019,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
> >  	return -EINVAL;
> >  }
> >
> > -int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> > +int btf_struct_access(struct bpf_verifier_log *log,
> > +		      const struct bpf_reg_state *reg, const struct btf *btf,
> >  		      const struct btf_type *t, int off, int size,
> >  		      enum bpf_access_type atype __maybe_unused,
> >  		      u32 *next_btf_id, enum bpf_type_flag *flag)
> >  {
> > +	bool local_type = reg && (type_flag(reg->type) & MEM_TYPE_LOCAL);
>
> Can you add a type_is_local_kptr helper (or similar name) to reduce this
> type_flag(reg->type) & MEM_TYPE_LOCAL repetition here and elsewhere in the patch?
> Some examples of repetition in verifier.c below.
>

Good point, it was there in RFC but for some reason I decided against it. I will
include it in v3.
