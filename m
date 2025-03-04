Return-Path: <bpf+bounces-53225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298EA4EB8D
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCCD8C2C6A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6A291F9B;
	Tue,  4 Mar 2025 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kogTMvLB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4B277010
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110959; cv=none; b=QJ0nWIN4ym8pK272H2Dfd2h2YuMosjVRm7Ybx6591LFi0VNU3EldOAIfq/X4K5JRqC56eEby/vmRIdJA8CTb/OFo8cvzOWc7Capu6Ydoe7vWTXxsuFv4Zk2GMQ4FcwKoO5ETaomJAQVLo3tIExt37TU1IvhQ1sKJ1SX1Nzp30M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110959; c=relaxed/simple;
	bh=8zBaRPz+Dejx+Z2USVRvP8hufsfH/GSxhE3Q8pWcBaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+mgtOhljaPRHmMvqfoQWMm7OhSnW9DFPGRcEuEPMG+SV5OdB0pAIOrBEIQfF3gjk/oMj+64wY7YQuafs2RlKzD+s2ghCDwJGbwBgEWINRsdzVZe1DvJRg8au5+liDAUqF1RFv7B3JYhA2SNWZRT5CjYgKFv9ww2cZK2oNWVGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kogTMvLB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22339936bbfso88979025ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741110957; x=1741715757; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rj07Tbk/WQ84gL3oyCOMaxyjlyVbBij3Fl6vDfWCPQA=;
        b=kogTMvLBaB9gAhWRH6x83HyHhWUVCvnQrRfqUXnT5tPa6Vjo6vqCZZkRRmG0Po98i6
         FBLFAnqLPLNFmCRBC5AkI3Sd9G+g49P95GQeXhcTzKEWXw07vyNIc4rtn5FH+Ql7otN9
         qH+DXvUY3NIEpsoqXSBinvv2BUGmy5AUU4dWoNnU9TC6U81WwYY3wZJo0obfA0162i8E
         Xa7EfY+dcKpUh1BQB5ID3v9QvuFykcOrsiOdjmt6RM4ykejVUQjQCp09Lrbt89a2En7H
         s2FD20QBDZ+QrnaGHJLDFBN1IzgeUwq4TkzD3Ic+AL/2Gj5iMZQNAGyCLtYdTF2qU+da
         XYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110957; x=1741715757;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rj07Tbk/WQ84gL3oyCOMaxyjlyVbBij3Fl6vDfWCPQA=;
        b=jNb2m0KnrMUAeGF+Ty8Q86wX1ls6mxI/08VQUEyC0DkWngMWnjZK/XT/8AmJ986dLP
         jJK5hv4t428KGUctik0tidIDDPqBdoyYyK9HN2TzEOJj5OWq9T2RBWr7RDWQNmSiXUUU
         +wTmzGiWbQXz00Q+HUuHZU0+g4aMcSSf9vgxnTb+gJLuX4v+0VQJtCyeSVUb5uyX4TnQ
         PjAEFts47mCXtyowOS7Xyl3+3ZBSn3LN0WKskrqWu6wBhH5ZkVTc1Bynemjuu6R78F7O
         cpKwxuuqTeqdANoYLxSFPySSCAv3Bbc/0tFvf8zR++DvDIWdm6r813ypWYglKKZU1Xq1
         qcqQ==
X-Gm-Message-State: AOJu0YyqH8Wy1sqFg01cRv4TY5ZGzEzAwy5Datw8YYQytHi2j7eMq2pn
	KLukvicC+y07AsO7rl3UXXEEPGgMkvkQLKEDhX+xRMxGix0k0FME
X-Gm-Gg: ASbGncubnMn+XrE5gZgYZKNJSWEsl5OVSqzYRQNWdindPe3HFSBwCCCBS1LTKqpcYf+
	G255G59u+Obwpef+l8CbN1jQ65l8N5ALMeVHec4jxSwItnZAQJJ+jaMaai5wClmm4vSG+V22w0N
	MVl7RuGsaRptPhY+Ope/7R2q84EYdFsZzoSfso4byBNvBzrvw1rrhhNgrFMUGPFn8ZF9VL2yIZi
	Ld1RCGKfKbyR15rvrARZbKBJ3ZF1ULQWqGpKETJGeU+F5li5PM6CZRcKRZYcTudBkeL4Oan6Lxw
	ot2rbEvezKqw3J/IL0+PejXX8P0JkzkiSJf55sp4vA==
X-Google-Smtp-Source: AGHT+IERAONjeq+QZm5z5aZ1WT7zz0w8Bc4rW4QaDbmLyfr54djyT6Wjt7+c1M0oMHRNRdT/IDDgfQ==
X-Received: by 2002:a17:903:2348:b0:21f:3e2d:7d2e with SMTP id d9443c01a7336-223f1ca9089mr961285ad.27.1741110956976;
        Tue, 04 Mar 2025 09:55:56 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c67sm98574735ad.135.2025.03.04.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:55:56 -0800 (PST)
Message-ID: <ad24890b32b7e6fbcb1ace4eefd8fa365e0de0e7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: simple DFA-based live registers
 analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Date: Tue, 04 Mar 2025 09:55:52 -0800
In-Reply-To: <CAADnVQ+gBOK_KODR0AD7tEVqjeCn9QTPjOjS=6A1bbbNr55nnA@mail.gmail.com>
References: <20250304074239.2328752-1-eddyz87@gmail.com>
	 <20250304074239.2328752-4-eddyz87@gmail.com>
	 <CAADnVQ+gBOK_KODR0AD7tEVqjeCn9QTPjOjS=6A1bbbNr55nnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 09:00 -0800, Alexei Starovoitov wrote:
> On Mon, Mar 3, 2025 at 11:43=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > +       case BPF_STX:
> > +               switch (mode) {
> > +               case BPF_MEM:
> > +                       def =3D 0;
> > +                       use =3D dst | src;
> > +                       break;
> > +               case BPF_ATOMIC:
> > +                       use =3D dst | src;
> > +                       if (insn->imm & BPF_FETCH) {
> > +                               if (insn->imm =3D=3D BPF_CMPXCHG)
> > +                                       def =3D r0;
> > +                               else
> > +                                       def =3D src;
> > +                       } else {
> > +                               def =3D 0;
> > +                       }
> > +                       break;
> > +               }
>=20
> This would need a follow up to recognize newly introduced
> load_acq/store_rel insns.

Missed that load_acq landed.
Will send v3 shortly.


