Return-Path: <bpf+bounces-73459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FAC32200
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 17:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF6044E0100
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E13321DF;
	Tue,  4 Nov 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8JXuPeN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748AE332913
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274719; cv=none; b=ElQJXFqVtuptbhWCsBiASCrRLxvngkfpoqnCEApLu3dw9wD6935DgAX/NNptBG8hxk1ltHdz9yGBB1mz8i2417PXVSMCzkXPdFL54j754lFrsdgcuUIEJokhvyRL20DIcjDxBe+DODCUQAENaJFUCBMUWj4mbJRBbmkFCuIhQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274719; c=relaxed/simple;
	bh=aaKfwJouT+s1kZJM/Pf/UAWL33j+seBywIcj7eo2A6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A21buNdj8AyeLUkSrkwb/nllzBSTaSSDiwIhNZZVTUM0nQVN0PL+7MMSVhLBatWdZzbkOWFgnbG6d4mjjTquDdUEQj08PkrNPBFmndnpxwri6C5WFjZI33iTcT8ypHL7zY1ZkSNDwYu8cZIcBRWlNdnDnoHNqf53muORCSJ+kFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8JXuPeN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47721743fd0so31189295e9.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 08:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762274715; x=1762879515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J5jMML10CUxfCOxIjk3Wr/ht2euT/2uZgkKwW6uC1c=;
        b=Z8JXuPeNi4bi/oUCmjOeMZqEZAJO7GKgbUkC7pTRHWUUOp1sqHLbnhlUNKsqqcGhS4
         z7tXuL/NzOvel9SK+Ue/nXK8s5/552Af+dzHALKdiMNa/QdLiypOiOfLEM4Tnz5Lw5cS
         ADf0fb8D7MYUhixvHWgxb/o+DmXMNNQzdHMX0D/cFfi3zRp6VTnha9lcRXHRRkl7WnGz
         m7KUwkqVjMuAAh3uqc5k8L0iPkaWGoIgwUIiSy/J/jZN3vB8NzgTzg4YqmehbgQC+m6l
         HYo3lYOw/0/1oYOaX4/cjIRW2JJUTZI8SBlxBY8eNFcXpgKOTUpw5ns1Tp8ZLiaB4A4u
         7vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274715; x=1762879515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J5jMML10CUxfCOxIjk3Wr/ht2euT/2uZgkKwW6uC1c=;
        b=d3AvoNVYxNjzC95hcUEbKdDG8c+T6boHKrlVaWWN2+VIpZC0PLLYOibAAW/h1oFdt0
         DWzPbnOhSOgNb4J9eV6aIJqODjELt3Wfp+QiZI7tkhrZ17tp63ywRT+V5zXSjtAUCHcr
         7+agM9KML5sgyenWZxRK0QOlXmYRfhKfuU7rQ50eyZBY/PuoX862lwTbD8snXJjV1zX+
         0IHAt93U/CiQnPY9sqmPoOWW8KVq+ATNBvYD444JvdWUr3VepViSFIzHvQAOKGPh3TH8
         4dr+XAbF4paf+wWdn1ONU5Rqo71p1rVF1C5HGVFisDaRxUYYEMz9T1osVzz8XR0XYvnk
         pXvg==
X-Forwarded-Encrypted: i=1; AJvYcCXne/zfQyiMA7IcpLodsE+mqgmfZ3ipjk2i03oU9qm39UzTRWlOC8xqGShIgo7QiyTCRA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKeNIhZqGpWAX+9m5C28XwOPaONReTdejxRF1I15kH5aRi9kg
	Yl63HWjwmEl4Fqkn1cxzF7sqdPXcKSmnyK3+yu76kQqAROq7YmqEMAZLrh9fssSRuMsP3SiO6HU
	l6Aq84pOXRLIgeK59lfXvdmylNIo8thA=
X-Gm-Gg: ASbGncuotiYqdtwcqnwYpX17JRMPTFi/XZwb/b/RMc8PAnvpjFpFoiRFvUtfu4zPbFa
	udgCP4NsoX/EGiHzDrK2cGxS/BNrQLNKJfTD5Z50euF0s1TfaLFjM9AaGf38AEEmljEvY1BpRx2
	1jLfOpklJTi8d7rr5sTshM1pu/5B7B1ZyaR+zsdoTG8o4O709fZu4GnbQl1ODD6NnHx0YJBw4sq
	NFJG1nLkUAo2K2eq0a/Sld8aMesqbsnJcT6SCa+HWeL0KBKKBdnTaEcvXZMRjBI/zhtEsjfQSv/
X-Google-Smtp-Source: AGHT+IFrVaCB9SSWYNypgwxAB2Lnwd/fvCgG0TrdTkW++wH29E7LC9uVy2NfP97YokrXLKgr9d+AnMqCOjbtiOXJVLA=
X-Received: by 2002:a05:600c:3d97:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-477308a159cmr127570595e9.26.1762274714743; Tue, 04 Nov 2025
 08:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028225544.1312356-3-alan.maguire@oracle.com>
 <f41705b65cd398234052e965943ab9dedf7f78fbed66d1b6e385a0e58db81c2b@mail.kernel.org>
 <8282b59a-4784-4e96-a459-6d238e2e1c6b@oracle.com>
In-Reply-To: <8282b59a-4784-4e96-a459-6d238e2e1c6b@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 08:45:01 -0800
X-Gm-Features: AWmQ_bkpEvQGcQbaPJHa3k9ZyVOnnWCyvV3ho86qK_7N4MoGAUagNO56d_cPRSU
Message-ID: <CAADnVQKQD562EsG2moTPjNpEK4k=zuqmismtQ_iTX3r8AszBOA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Test parsing of
 (multi-)split BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Thierry Treyer <ttreyer@meta.com>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 4:15=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 28/10/2025 23:25, bot+bpf-ci@kernel.org wrote:
> >
> > ```
> > commit 9da54f1ee8589391857dcb28c0dbc65a8e6632ea
> > Author: Alan Maguire <alan.maguire@oracle.com>
> >
> > selftests/bpf: Test parsing of (multi-)split BTF
> >
> > This patch adds a test that writes raw BTF data to files, parses it
> > back, and compares the parsed BTF to the original to verify correctness
> > of the BTF parsing code.
> >
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tool=
s/testing/selftests/bpf/prog_tests/btf_split.c
> >> index 3696fb9a0..b07a91ff2 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
> >
> > [ ... ]
> >
> >> @@ -123,6 +157,38 @@ static void __test_btf_split(bool multi)
> >>  "   int uf2;\n"
> >>  "};\n\n", "c_dump");
> >>
> >> +    /* write base, split BTFs to files and ensure parsing succeeds */
> >> +    base_btf_sz =3D btf_raw_write(btf1, base_btf_file);
> >> +    if (base_btf_sz < 0)
> >> +            goto cleanup;
> >> +    split_btf_sz =3D btf_raw_write(btf2, split_btf_file);
> >> +    if (split_btf_sz < 0)
> >> +            goto cleanup;
> >> +    btf4 =3D btf__parse(base_btf_file, NULL);
> >> +    if (!ASSERT_OK_PTR(btf4, "parse_base"))
> >> +            goto cleanup;
> >> +    btf5 =3D btf__parse_split(split_btf_file, btf4);
> >> +    if (!ASSERT_OK_PTR(btf5, "parse_split"))
> >> +            goto cleanup;
> >> +    if (multi) {
> >> +            multisplit_btf_sz =3D btf_raw_write(btf3, multisplit_btf_=
file);
> >> +            if (multisplit_btf_sz < 0)
> >> +                    goto cleanup;
> >> +            btf6 =3D btf__parse_split(multisplit_btf_file, btf5);
> >> +            if (!ASSERT_OK_PTR(btf6, "parse_multisplit"))
> >> +                    goto cleanup;
> >> +    } else {
> >> +            btf6 =3D btf5;
> >> +    }
> >> +
> >> +    /* compare parsed to original BTF */
> >> +    for (i =3D 1; i < btf__type_cnt(btf6); i++) {
> >> +            t =3D btf__type_by_id(btf6, i);
> >> +            ot =3D btf__type_by_id(btf3, i);
> >> +            if (!ASSERT_EQ(memcmp(t, ot, sizeof(*ot)), 0, "cmp_parsed=
_orig_btf"))
> >> +                    goto cleanup;
> >> +    }
> >> +
> >
> > Can btf__type_by_id return NULL here in the comparison loop? The loop
> > iterates based on btf6's type count, but accesses types in both btf6
> > and btf3. If btf6 has more types than btf3 (indicating a parsing bug),
> > then btf__type_by_id(btf3, i) will return NULL when i exceeds btf3's
> > type count, leading to a NULL dereference in memcmp.
> >
> > Other btf__type_by_id calls in this function (see earlier uses) check
> > the return value with ASSERT_OK_PTR before dereferencing. Should this
> > code either verify the type counts match first, or check these return
> > values to maintain consistency with the rest of the function?
> >
>
> Should I respin a v4 with the bot's suggestion here? Perhaps along with
> an ASSERT_EQ() that btf__type_cnt(btf3) =3D=3D btf__type_cnt(btf6) ? Than=
ks!

Yes. The assert for equal length will surely help.

pw-bot: cr

