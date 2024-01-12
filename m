Return-Path: <bpf+bounces-19496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E7C82C82A
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 00:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0841B22BF0
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C151A5B7;
	Fri, 12 Jan 2024 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="QGHynvZw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E81A5AC
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-598a2cb5a7cso1131093eaf.2
        for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 15:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705103877; x=1705708677; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZLyvjXL3z0iDp/oXvt5DkUIHIjwlF9DPdQa4hrM5hM=;
        b=QGHynvZwlTyaWcBcCG4xB8nL1hdNVvXdhQ0sA5U31Au+0OnBq29s6IyEMtjJaS9a7h
         jST4M2B08s2y98uzlZNF9tYZcPrUYAjSD9jjIN5vkGqRy47VoGqhq8TsRSCYrFwYBRV3
         h9lbXRqiAQUF/YZEa4Dl+CpWwUXp3Skk0w9fAOadNkG/OY3zoFc6sicB14e3YjCBhpeL
         quo8kku8X0cmtVbtD1DL+hpK4HBKYjqFe+TpMFsYKBLOyUX2trLCbpMpkjOpcu3gsLA/
         THmhqlFFZtzm4dQ2wmQcXJv8PcXkkQaI+zxota335ursT2J/bzKvYq+AJf/0l1T4Cz/0
         LrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705103877; x=1705708677;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZLyvjXL3z0iDp/oXvt5DkUIHIjwlF9DPdQa4hrM5hM=;
        b=kwnnGtE3lYYM+YUBWZy/c5k4fbRERG8XU7miZIUycIuUi/SNRP8XWRH1VqeoPtHET7
         p812fHepqPq7CpoOxtz4Dk22Kp+CRzQMg5hYMV15A2WxBs0K0XpOj2Pq01czP76/M6eK
         Z1Gb3iijjLYA1tPfNwDMPkdSLRGgaKubeyJjWBOWr+f8wG8RHYJJszL3lmj+4LO9SIet
         LIlXR8uEKdo3tucRlnJ1HelQfeiE2HDc/CQG4iVpW+3hUu/P7rwqv+DE3lcQSiDa++RA
         a3WtxWNHi2NesGQSYL2SBuOnwnirPzYabuz/x2qHGmYE4fJ7Pv/KV2AAwCyP9ANbnTUp
         xh6w==
X-Gm-Message-State: AOJu0Yw57XgFAfU1h6t0Esz25hDT69HPtWHKgwcfnu8JVB8Of7A3UDZP
	9Le0VPEkhVCn44H5Is++or4QaXTJ4r6Qfw==
X-Google-Smtp-Source: AGHT+IH/tyZC4WB46C/ivOo2a7DWIQFEWwo2JSPB5XKhcZ8/vYf2ouQU/dED2vtxn5Qj7MkaJHXBBw==
X-Received: by 2002:a05:6358:c309:b0:175:7be3:d4ab with SMTP id fk9-20020a056358c30900b001757be3d4abmr2408104rwb.4.1705103877478;
        Fri, 12 Jan 2024 15:57:57 -0800 (PST)
Received: from ?IPv6:2601:647:4900:1fbb:1985:323f:332f:3b61? ([2601:647:4900:1fbb:1985:323f:332f:3b61])
        by smtp.gmail.com with ESMTPSA id qj7-20020a17090b28c700b0028bcc2a47e9sm7152085pjb.38.2024.01.12.15.57.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2024 15:57:57 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf 2/3] bpf: Avoid iter->offset making backward
 progress in bpf_iter_udp
From: Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <20240112190530.3751661-3-martin.lau@linux.dev>
Date: Fri, 12 Jan 2024 15:57:55 -0800
Cc: bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org,
 kernel-team@meta.com,
 Yonghong Song <yonghong.song@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B865DECA-2350-471F-B75B-A9D2F33672CA@isovalent.com>
References: <20240112190530.3751661-1-martin.lau@linux.dev>
 <20240112190530.3751661-3-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)



> On Jan 12, 2024, at 11:05 AM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> There is a bug in the bpf_iter_udp_batch() function that stops
> the userspace from making forward progress.
>=20
> The case that triggers the bug is the userspace passed in
> a very small read buffer. When the bpf prog does bpf_seq_printf,
> the userspace read buffer is not enough to capture the whole bucket.
>=20
> When the read buffer is not large enough, the kernel will remember
> the offset of the bucket in iter->offset such that the next userspace
> read() can continue from where it left off.
>=20
> The kernel will skip the number (=3D=3D "iter->offset") of sockets in
> the next read(). However, the code directly decrements the
> "--iter->offset". This is incorrect because the next read() may
> not consume the whole bucket either and then the next-next read()
> will start from offset 0. The net effect is the userspace will
> keep reading from the beginning of a bucket and the process will
> never finish. "iter->offset" must always go forward until the
> whole bucket is consumed.
>=20
> This patch fixes it by using a local variable "resume_offset"
> and "resume_bucket". "iter->offset" is always reset to 0 before
> it may be used. "iter->offset" will be advanced to the
> "resume_offset" when it continues from the "resume_bucket" (i.e.
> "state->bucket =3D=3D resume_bucket"). This brings it closer to
> the bpf_iter_tcp's offset handling which does not suffer
> the same bug.
>=20
> Cc: Aditi Ghag <aditi.ghag@isovalent.com>
> Fixes: c96dac8d369f ("bpf: udp: Implement batching for sockets =
iterator")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Aditi Ghag <aditi.ghag@isovalent.com>
=20
Thanks!

> ---
> net/ipv4/udp.c | 21 ++++++++++-----------
> 1 file changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 978b83d3c094..04c534a9ef89 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3137,16 +3137,18 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
> 	struct bpf_udp_iter_state *iter =3D seq->private;
> 	struct udp_iter_state *state =3D &iter->state;
> 	struct net *net =3D seq_file_net(seq);
> +	int resume_bucket, resume_offset;
> 	struct udp_table *udptable;
> 	unsigned int batch_sks =3D 0;
> 	bool resized =3D false;
> 	struct sock *sk;
>=20
> +	resume_bucket =3D state->bucket;
> +	resume_offset =3D iter->offset;
> +
> 	/* The current batch is done, so advance the bucket. */
> -	if (iter->st_bucket_done) {
> +	if (iter->st_bucket_done)
> 		state->bucket++;
> -		iter->offset =3D 0;
> -	}
>=20
> 	udptable =3D udp_get_table_seq(seq, net);
>=20
> @@ -3166,19 +3168,19 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
> 	for (; state->bucket <=3D udptable->mask; state->bucket++) {
> 		struct udp_hslot *hslot2 =3D =
&udptable->hash2[state->bucket];
>=20
> -		if (hlist_empty(&hslot2->head)) {
> -			iter->offset =3D 0;
> +		if (hlist_empty(&hslot2->head))
> 			continue;
> -		}
>=20
> +		iter->offset =3D 0;
> 		spin_lock_bh(&hslot2->lock);
> 		udp_portaddr_for_each_entry(sk, &hslot2->head) {
> 			if (seq_sk_match(seq, sk)) {
> 				/* Resume from the last iterated socket =
at the
> 				 * offset in the bucket before iterator =
was stopped.
> 				 */
> -				if (iter->offset) {
> -					--iter->offset;
> +				if (state->bucket =3D=3D resume_bucket =
&&
> +				    iter->offset < resume_offset) {

I like this invariant of ensuring that the batching and resume =
operations are performed for the same bucket under consideration.


> +					++iter->offset;
> 					continue;
> 				}
> 				if (iter->end_sk < iter->max_sk) {
> @@ -3192,9 +3194,6 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>=20
> 		if (iter->end_sk)
> 			break;
> -
> -		/* Reset the current bucket's offset before moving to =
the next bucket. */
> -		iter->offset =3D 0;
> 	}
>=20
> 	/* All done: no batch made. */
> --=20
> 2.34.1
>=20


