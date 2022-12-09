Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBDA64824B
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 13:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLIMST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIMSS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 07:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5849B51
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 04:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670588245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2GUk3oMyTRq5X9Iw+DPtIYelaDcgYe59Br+cHmaBTQ=;
        b=akEOs5KkIzFAfWV/jUlLlpAxNRFOM18Ag0FHSZgAPQRAEswzsayb1Z6rpGNLIsL0mjAqdc
        C+qgwH3xH+N7hzZKQKMrSxkjxZnBTX4jVGFrVnIFW3MB9gNluFn7bI3Zt65lhgfCHtCuu7
        dP5BV/CV8rTEMeUr6EU9/dQzqOog/nc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-Txo_Dx5qNaS7CV2MCHAraA-1; Fri, 09 Dec 2022 07:17:22 -0500
X-MC-Unique: Txo_Dx5qNaS7CV2MCHAraA-1
Received: by mail-ed1-f72.google.com with SMTP id f17-20020a056402355100b00466481256f6so1255849edd.19
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 04:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2GUk3oMyTRq5X9Iw+DPtIYelaDcgYe59Br+cHmaBTQ=;
        b=2UW1ktNugbSrc6q++ru7DNiVhFN44W7T2DZh55hah3mCsdr8ftLUjbyrGsYOb70ykN
         p+hAbHqnUUY1mHuH+xUzrTrFvtzVSDQDWHRjjhuWU8iTSipl22xfqjpPWiRbgMv48d5L
         h4aaJSfq0zgWK2MsXcZHlh8McsmkoLdzmPRWjdLWwdlcVLsnbYQXWyswbJgctDw2b3ol
         Vt0uYOKE+3+Ti8bFAsdZ5Cr0oW5Q4jQjuyeUUfZ0LwoL9ktxG+ab7IboFTvFfDJeOc3f
         7RafP2rWdjZilFrYz6Y5EyRec7DlE/scAAVJrz5RgZMvXgfjNKtsgy3Is/2xc8J9c33p
         9P8A==
X-Gm-Message-State: ANoB5pnIUS9X3WkN39tAbhTvOXwS5jxxd71SXAruBH2UgjKkQ5G8MtrU
        XvFtcYW5qzx/1IbUx7v89lOxquTL+eHTaOr1no45hUo6fC5KVEqLYqoXNrY3MdiUNyD9jAukG5c
        o/Nn+dUXCE3LU
X-Received: by 2002:a17:906:2442:b0:7ad:8f6f:806d with SMTP id a2-20020a170906244200b007ad8f6f806dmr4520195ejb.24.1670588241234;
        Fri, 09 Dec 2022 04:17:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4+W6txJygHcxBpQSo9+07FyylKtLr5y2PY0CpSGejtrR7LGM0vscA1HMB7WUCgIii5Vcvtaw==
X-Received: by 2002:a17:906:2442:b0:7ad:8f6f:806d with SMTP id a2-20020a170906244200b007ad8f6f806dmr4520168ejb.24.1670588240818;
        Fri, 09 Dec 2022 04:17:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906c30f00b007c0c679ca2fsm500997ejz.26.2022.12.09.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 04:17:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C3F4882EB13; Fri,  9 Dec 2022 13:17:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Resolve fext program type when checking map
 compatibility
In-Reply-To: <69cff1f4-b023-b064-bd47-f44e6c2b6d80@meta.com>
References: <20221208003546.14873-1-toke@redhat.com>
 <69cff1f4-b023-b064-bd47-f44e6c2b6d80@meta.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 09 Dec 2022 13:17:09 +0100
Message-ID: <87ilikkbzu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@meta.com> writes:

> On 12/7/22 4:35 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The bpf_prog_map_compatible() check makes sure that BPF program types are
>> not mixed inside BPF map types that can contain programs (tail call maps,
>> cpumaps and devmaps). It does this by setting the fields of the map->own=
er
>> struct to the values of the first program being checked against, and
>> rejecting any subsequent programs if the values don't match.
>>=20
>> One of the values being set in the map owner struct is the program type,
>> and since the code did not resolve the prog type for fext programs, the =
map
>> owner type would be set to PROG_TYPE_EXT and subsequent loading of progr=
ams
>> of the target type into the map would fail.
>>=20
>> This bug is seen in particular for XDP programs that are loaded as
>> PROG_TYPE_EXT using libxdp; these cannot insert programs into devmaps and
>> cpumaps because the check fails as described above.
>>=20
>> Fix the bug by resolving the fext program type to its target program type
>> as elsewhere in the verifier. This requires constifying the parameter of
>> resolve_prog_type() to avoid a compiler warning from the new call site.
>>=20
>> Fixes: f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Could you construct a test case for this problem?

Sure, will add a selftest and send a v2.

-Toke

