Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02F626227
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiKKTkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiKKTkF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:40:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0857BE6E;
        Fri, 11 Nov 2022 11:40:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z18so8965482edb.9;
        Fri, 11 Nov 2022 11:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iIxp/mPo3mFGgHN1vW8WFds+pL6kSiHERkF88oy0nuY=;
        b=C/2iAk6+kH5VzDsjr3MHHWskEU1SY8T1nf3MZY2S8UdzGSSmts9ZD8dAT1xbRpjE8p
         TEmj6UT7y6vKt4AJICvx+cH+c/gV55UobVN1aa3jzd+TMXZD6CHyE8D8vq047tEK8fwK
         o7MpKMtXEonNineWoLG8HuVvG7rb+T/6VSvEhGoE+XIngdO39F6WkDCG91eq/JyBYOQk
         tnKIWgRVWYHfO/B/2E4VUXCHMe3sjOJTj1Zl0aIRBdfyDILt/Arg5eSa5L9nIVGhnR3J
         GHpwKA5J7j+altDCNZBQwFph8aMRU/G4Lioorq3YFVP8BCOpe2VrGPDcuq9eYkFOzrY0
         ZsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIxp/mPo3mFGgHN1vW8WFds+pL6kSiHERkF88oy0nuY=;
        b=X9M1AxNukoYmZpdfELHaL4wcu7JQe4pbwKKGxnYcjEGd6N6l8AWykhPDACkffVjiAS
         m/E02bjwhM8CWt7VBDTwpOuKhbh5Iq4zeqVFCB/EE+NAZa2rheYPSHKjHFhsHzeT7A0g
         IAajBLEgNPrHw3Ou+QpPUVPs9sxINFniEGfW954emwGTD3lI1aJNTrHGjfy4pqJgA+Vc
         U7zWIzMKeLsHgpxqPCSXw3CI6X+bIFM+qVmQg2puJt+64lWRfPaU3ZzAYC8hPcqlOXXC
         PjjLbie8ebSIkblRdiWDgVefLcMmYgE9GFL+GesYOVOA+IMWcrTuuAL//CzEANm2yl/z
         Dh5A==
X-Gm-Message-State: ANoB5pkhJRWDSklhn45alzf7/gB8+d80Dghav5ujyk0eewVcRq8SPRH8
        Wf+gxnuwJnfYNpw/eW6H46QPk8hJB6pvOLQYOIA=
X-Google-Smtp-Source: AA0mqf7LgpBRFBqox6+gOFVvPCnk/f6pFwZ2U9GHIaWS2F/n31NX8FevklVGYBTTVjUwX42j5spgIGSbNAlYYknMjaY=
X-Received: by 2002:a50:9512:0:b0:457:1323:1b7e with SMTP id
 u18-20020a509512000000b0045713231b7emr2736138eda.311.1668195603464; Fri, 11
 Nov 2022 11:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20221109174604.31673-1-donald.hunter@gmail.com> <20221109174604.31673-2-donald.hunter@gmail.com>
In-Reply-To: <20221109174604.31673-2-donald.hunter@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 11:39:51 -0800
Message-ID: <CAEf4Bzak4A-vP=NeJheA0poiu_8fK53cvbq1EnnSHC78FB7mtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Tucker <dave@dtucker.co.uk>,
        Maryam Tahhan <mtahhan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 9:46 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> From: Dave Tucker <dave@dtucker.co.uk>
>
> Add documentation for the BPF_MAP_TYPE_ARRAY including kernel version
> introduced, usage and examples. Also document BPF_MAP_TYPE_PERCPU_ARRAY
> which is similar.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> Co-developed-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Reviewed-by: Maryam Tahhan <mtahhan@redhat.com>
> ---
>  Documentation/bpf/map_array.rst | 250 ++++++++++++++++++++++++++++++++
>  1 file changed, 250 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst
>

[...]

> +This example BPF program shows how to access an array element.
> +
> +.. code-block:: c
> +
> +    int bpf_prog(struct __sk_buff *skb)
> +    {
> +            struct iphdr ip;
> +            int index;
> +            long *value;
> +
> +            if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip, sizeof(ip)) < 0)
> +                    return 0;
> +
> +            index = ip.protocol;
> +            value = bpf_map_lookup_elem(&my_map, &index);
> +            if (value)
> +                    __sync_fetch_and_add(value, skb->len);

should be &value

I fixed it up and applied to bpf-next, thanks.

> +
> +            return 0;
> +    }
> +
> +Userspace
> +---------
> +
> +BPF_MAP_TYPE_ARRAY
> +~~~~~~~~~~~~~~~~~~
> +
> +This snippet shows how to create an array, using ``bpf_map_create_opts`` to
> +set flags.
> +

[...]
