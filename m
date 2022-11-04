Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAABC619271
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 09:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKDIJu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKDIJs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 04:09:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2436264B4
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 01:09:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id io19so4198471plb.8
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4e3OOyJqg/mlEE//Jzuknx7eV8c6PpiUnvTzSJaGXU=;
        b=l8SauS41GHdjW0uUWHtznx5CKvYE4BgwayY6QZhKoMtkWdYXXRl4YzDqQuDLpKTRJn
         FpxP6D/UbtsBwwxhmt5Z0E41KtKlhhTwrnZlZyChnRGA1sOIUFLdS6wlMDSyRLiiMNEt
         tOz7mradRvdgeDJsW+4YgeM8KMkTxnJZgyT/r1IdHNl2sAcmEufputVOubOjLmWV4PXB
         xibDbg3C5qwvoQoF5v474QHezHKy9YnOmglYFsTLU+SuWO8yK9HSllHFrDtRsl7dELog
         szzZFUw11E3Fwa+huD45G5Clbv85fVnj1m8twxPa7SkiHfl9M7EjAguetFW60/HfDFal
         XvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4e3OOyJqg/mlEE//Jzuknx7eV8c6PpiUnvTzSJaGXU=;
        b=foR+mO73VXFALms7edoVRHNAabdwnEtnTgWDJPQ1j9UtzXvxEsW5mwfmxTXFG1dv7+
         I860bzuWbm7XoZY98T7A/E0ZpcZvgR93hC+v1QSOTRXpEcpJXeZ+IxUvO40+9IHVsu5w
         18UhDSlwNLF7Y24XTcZDG7f2WmPSKJZ+7VMCIJzVYULVeSiXx52noeK6TuirQfkoItDA
         iMPmwAIA9kTWgZ8CuMTLOoVK2ajDmqC32LbOHvOCNSVhtgpxvTbfwz6bl03SXjUBL9WP
         CKvmIv3L9nzvGswSeiuks0P4x93I/kiY2/jJMMLFk+EenC+LZuStHGnCKHzrsfAkFVd4
         VAGw==
X-Gm-Message-State: ACrzQf3OILOlYSDeVexWN/sgTabCVhoF62p2nRBPujpdSrCTAoFN6Esn
        eSnN3JyBsJLtupy/eF36fsg=
X-Google-Smtp-Source: AMsMyM6RbYzmCBMTXUZOHRwYit4UxmsofB+M7boDtSJv/JHnhG3i00uNk4u8bP+Fl/l/+ZCdoFiI/g==
X-Received: by 2002:a17:902:d38d:b0:186:9fc5:6c13 with SMTP id e13-20020a170902d38d00b001869fc56c13mr34511214pld.73.1667549387125;
        Fri, 04 Nov 2022 01:09:47 -0700 (PDT)
Received: from localhost ([157.51.134.255])
        by smtp.gmail.com with ESMTPSA id 126-20020a621984000000b0055f209690c0sm2078990pfz.50.2022.11.04.01.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:09:46 -0700 (PDT)
Date:   Fri, 4 Nov 2022 13:39:43 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 19/24] bpf: Introduce bpf_obj_new
Message-ID: <20221104080943.fud4grm5tzp6tl3h@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-20-memxor@gmail.com>
 <ba1a01b3-8028-fdbb-910b-19612e22bf5f@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba1a01b3-8028-fdbb-910b-19612e22bf5f@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 08:07:25AM IST, Dave Marchevsky wrote:
> On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
> > Introduce type safe memory allocator bpf_obj_new for BPF programs. The
> > kernel side kfunc is named bpf_obj_new_impl, as passing hidden arguments
> > to kfuncs still requires having them in prototype, unlike BPF helpers
> > which always take 5 arguments and have them checked using bpf_func_proto
> > in verifier, ignoring unset argument types.
> >
> > Introduce __ign suffix to ignore a specific kfunc argument during type
> > checks, then use this to introduce support for passing type metadata to
> > the bpf_obj_new_impl kfunc.
> >
> > The user passes BTF ID of the type it wants to allocates in program BTF,
> > the verifier then rewrites the first argument as the size of this type,
> > after performing some sanity checks (to ensure it exists and it is a
> > struct type).
> >
> > The second argument is also fixed up and passed by the verifier. This is
> > the btf_struct_meta for the type being allocated. It would be needed
> > mostly for the offset array which is required for zero initializing
> > special fields while leaving the rest of storage in unitialized state.
> >
> > It would also be needed in the next patch to perform proper destruction
> > of the object's special fields.
> >
> > A convenience macro is included in the bpf_experimental.h header to hide
> > over the ugly details of the implementation, leading to user code
> > looking similar to a language level extension which allocates and
> > constructs fields of a user type.
> >
> > struct bar {
> > 	struct bpf_list_node node;
> > };
> >
> > struct foo {
> > 	struct bpf_spin_lock lock;
> > 	struct bpf_list_head head __contains(bar, node);
> > };
> >
> > void prog(void) {
> > 	struct foo *f;
> >
> > 	f = bpf_obj_new(typeof(*f));
> > 	if (!f)
> > 		return;
> > 	...
> > }
> >
> > A key piece of this story is still missing, i.e. the free function,
> > which will come in the next patch.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > new file mode 100644
> > index 000000000000..1d3451084a68
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>
> Maybe bpf_experimental.h should go in libbpf as part of this series? If
> including vmlinux.h is an issue - nothing in libbpf currently includes it - you
> could rely on the BPF program including it, with a comment similar to "Note
> that bpf programs need to include..." in lib/bpf/bpf_helpers.h .
>

I don't have a problem with that, but I would like to also know Andrii's opinion
on this, since it won't work properly if people don't keep libbpf and kernel
version in sync.
