Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF36150A6E1
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390518AbiDURUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357484AbiDURUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 13:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D98049F3C
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650561437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M85VEuGKICC+n3KmirUiOXeY6w4YMv3PH/049fpWFT4=;
        b=X0/OK2bLQmZcUw9YabrM6TuMYOfyfYYCZBa3iQTk3HIs3ViondTjZAGtrIjq/LHTYb1svS
        43Ua1dzozMm6r3KiZM/DPYqMijtZx8OB1p9vupNJz+jliQ1/l8OW68i9etMv69RKx/9SKp
        RuiviZiy1wZPzTcz/mCp/+8+sy4dxmE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-QmqmAzY_MEKnUdzmywZqqQ-1; Thu, 21 Apr 2022 13:17:15 -0400
X-MC-Unique: QmqmAzY_MEKnUdzmywZqqQ-1
Received: by mail-ej1-f71.google.com with SMTP id jg25-20020a170907971900b006f010192c19so2079512ejc.21
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 10:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=M85VEuGKICC+n3KmirUiOXeY6w4YMv3PH/049fpWFT4=;
        b=VEj+y3uNs8AFBCfjIYyWLdyVE3iczF1bhNMRDRMd8N6Mv9wusaRLISHZg1A4LX7OU5
         6GjS0MN/3/NaT2HrkSk74EgVuXY+BDgjHtGNuqV6eevjw9KiDwEdfapR+GvpZUK/igph
         Mok3lyMeTGVEXVBCLzaKHAXVR4+VbKa+jldbyNA5NiwPst91V5bN8KGwOkfH6ZZ6whMz
         fc2Uv0IXe5OC/BRnGZ39tpMxSSOu1++lptmssZLNZqThf2EiKMfd9JBnhLQGvDTpP+UR
         gTpSUBTyX6Y6GhWfS11HnOUjxneXomHh9MDhpQcfL48D3xr/q8Le4FVlvMCAguf8XVSq
         jRDA==
X-Gm-Message-State: AOAM533qjWxh5BPAH80iYUlDn26JVaB6KanV9RQzxb7QtnyqOY4Fz69W
        Srromi73L1YPJYOxtUCvmHNQDvjk0CdlcZokkvDWc1GrSI7sNj+rM3FUSAioTg+q+2h5Wn3Sbyo
        AEAEBd8U9dymQ
X-Received: by 2002:a05:6402:1e88:b0:412:fc6b:f271 with SMTP id f8-20020a0564021e8800b00412fc6bf271mr567774edf.345.1650561434028;
        Thu, 21 Apr 2022 10:17:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1o6WVynP3ShtVEcPoKZ6UeGi2/OrelvfMF1HW+lsBSiDp9GefHJMHz6u4NXKhpx6kyYoL8Q==
X-Received: by 2002:a05:6402:1e88:b0:412:fc6b:f271 with SMTP id f8-20020a0564021e8800b00412fc6bf271mr567747edf.345.1650561433675;
        Thu, 21 Apr 2022 10:17:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id kj23-20020a170907765700b006e8973a14d8sm8006169ejc.30.2022.04.21.10.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:17:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DCA3A2D1DE0; Thu, 21 Apr 2022 19:17:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Larysa Zaremba <larysa.zaremba@intel.com>,
        bpf <bpf@vger.kernel.org>
Cc:     Larysa Zaremba <larysa.zaremba@intel.com>,
        netdev <netdev@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: Accessing XDP packet memory from the end
In-Reply-To: <20220421155620.81048-1-larysa.zaremba@intel.com>
References: <20220421155620.81048-1-larysa.zaremba@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 21 Apr 2022 19:17:11 +0200
Message-ID: <87czhagxuw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Larysa Zaremba <larysa.zaremba@intel.com> writes:

> Dear all,
> Our team has encountered a need of accessing data_meta in a following way:
>
> int xdp_meta_prog(struct xdp_md *ctx)
> {
> 	void *data_meta_ptr = (void *)(long)ctx->data_meta;
> 	void *data_end = (void *)(long)ctx->data_end;
> 	void *data = (void *)(long)ctx->data;
> 	u64 data_size = sizeof(u32);
> 	u32 magic_meta;
> 	u8 offset;
>
> 	offset = (u8)((s64)data - (s64)data_meta_ptr);
> 	if (offset < data_size) {
> 		bpf_printk("invalid offset: %ld\n", offset);
> 		return XDP_DROP;
> 	}
>
> 	data_meta_ptr += offset;
> 	data_meta_ptr -= data_size;
>
> 	if (data_meta_ptr + data_size > data) {
> 		return XDP_DROP;
> 	}
> 		
> 	magic_meta = *((u32 *)data);
> 	bpf_printk("Magic: %d\n", magic_meta);
> 	return XDP_PASS;
> }
>
> Unfortunately, verifier claims this code attempts to access packet with
> an offset of -2 (a constant part) and negative offset is generally forbidden.
>
> For now we have 2 solutions, one is using bpf_xdp_adjust_meta(),
> which is pretty good, but not ideal for the hot path.
> The second one is the patch at the end.
>
> Do you see any other way of accessing memory from the end of data_meta/data?
> What do you think about both suggested solutions?

The problem is that the compiler is generating code that the verifier
doesn't understand. It's notoriously hard to get LLVM to produce code
that preserves the right bounds checks which is why projects like Cilium
use helpers with inline ASM to produce the right loads, like in [0].

Adapting that cilium helper to load from the metadata area, your example
can be rewritten as follows (which works just fine with no verifier
changes):

static __always_inline int
xdp_load_meta_bytes(const struct xdp_md *ctx, __u64 off, void *to, const __u64 len)
{
	void *from;
	int ret;
	/* LLVM tends to generate code that verifier doesn't understand,
	 * so force it the way we want it in order to open up a range
	 * on the reg.
	 */
	asm volatile("r1 = *(u32 *)(%[ctx] +8)\n\t"
		     "r2 = *(u32 *)(%[ctx] +0)\n\t"
		     "%[off] &= %[offmax]\n\t"
		     "r1 += %[off]\n\t"
		     "%[from] = r1\n\t"
		     "r1 += %[len]\n\t"
		     "if r1 > r2 goto +2\n\t"
		     "%[ret] = 0\n\t"
		     "goto +1\n\t"
		     "%[ret] = %[errno]\n\t"
		     : [ret]"=r"(ret), [from]"=r"(from)
		     : [ctx]"r"(ctx), [off]"r"(off), [len]"ri"(len),
		       [offmax]"i"(__CTX_OFF_MAX), [errno]"i"(-EINVAL)
		     : "r1", "r2");
	if (!ret)
		__builtin_memcpy(to, from, len);
	return ret;
}


SEC("xdp")
int xdp_meta_prog(struct xdp_md *ctx)
{
        void *data_meta_ptr = (void *)(long)ctx->data_meta;
        void *data = (void *)(long)ctx->data;
        __u32 magic_meta;
        __u8 offset;
	int ret;

        offset = (__u8)((__s64)data - (__s64)data_meta_ptr);
	ret = xdp_load_meta_bytes(ctx, offset - 4, &magic_meta, sizeof(magic_meta));
	if (ret) {
		bpf_printk("load bytes failed: %d\n", ret);
                return XDP_DROP;
	}

        bpf_printk("Magic: %d\n", magic_meta);
        return XDP_PASS;
}

-Toke


[0] https://github.com/cilium/cilium/blob/master/bpf/include/bpf/ctx/xdp.h#L35

