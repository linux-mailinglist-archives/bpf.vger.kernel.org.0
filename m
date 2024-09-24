Return-Path: <bpf+bounces-40217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D983E983A99
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 02:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54CE1C21915
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B09184E;
	Tue, 24 Sep 2024 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="i2R1pP9S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720D4C8E
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138016; cv=none; b=cHjNfFtH0npLFgP4ZlmSWJpJdXZ66C0psuN4FpJrWSedvkGKBlECwt5cpD5IT5+sacPN+6ZKLEvarxooY8AY6b4MV9/77Bk+x39tY7uUIBEacaSs8T+DR77ZgDOz4Sn7eN4QlNCQUVNC9kleFlkhgU7BTzu2m21nVBwzFP7X5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138016; c=relaxed/simple;
	bh=eF2SK8EfDmwEaAm1AiXHJmJAhQ7CsqgEH5IbQpqLiwY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBbrF55PBE7FlDM5MFPwKulB4NYZdoai4OWRGj6//YZgAnv4gQNGHMeD1oqLGUN3mrjRz0lFLekkjELmuWz1AXtLgdh1PkJblYO8G2p8ZCOYpdXdLYe/CG3DxHEEvsXzInKAqDRxBdtUydh2yiTg2cSVxXwiZOv75WLmBE3iPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=i2R1pP9S; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1727138012; x=1727397212;
	bh=7aTBvZLVWZqDdzJghM28XrnTSgU9th/67kJRvylLxLg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i2R1pP9S8X+31SxdKKffJAIKsE9ASq8PGdAF76NBl+9fDBvEBEWmrkagC8HIo0u93
	 ZBQh3typSGK1azqjlB3KyHX3TuUkiMNujcSt+0LLJz178YdNiy1yfUW/qHJx1LXc7R
	 I0eI8C7C3Mfbli3Hu4ANWKXiEuoIFBlvIBfw8BFn5sjyKSw9g2G73lK0IFRmlOZQvu
	 tuQntnnMw5Z5KHEzXn8j/a6p+3hKNKBOzjN6aMdCXmDngOGSGxZmTi2uqo3KVdmAbl
	 Xe7/hkbMybCwAhnb0wkCRnMshJ8JXtYZ5NcSX23DNtXkURDC29QPf/v/leHFOA7qCR
	 yoCpwOAwiPHEg==
Date: Tue, 24 Sep 2024 00:33:29 +0000
To: Jiri Olsa <jolsa@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCHv3 bpf-next 2/2] selftests/bpf: Add uprobe multi consumers test
Message-ID: <w6U8Z9fdhjnkSp2UaFaV1fGqJXvfLEtDKEUyGDkwmoruDJ_AgF_c0FFhrkeKW18OqiP-05s9yDKiT6X-Ns-avN_ABf0dcUkXqbSJN1TQSXo=@pm.me>
In-Reply-To: <20240722202758.3889061-3-jolsa@kernel.org>
References: <20240722202758.3889061-1-jolsa@kernel.org> <20240722202758.3889061-3-jolsa@kernel.org>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: ed76aa4a72617515dae3224e1a1b93e9349f67f3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, July 22nd, 2024 at 1:27 PM, Jiri Olsa <jolsa@kernel.org> wrote:

>=20
>=20
> Adding test that attaches/detaches multiple consumers on
> single uprobe and verifies all were hit as expected.
>=20
> Signed-off-by: Jiri Olsa jolsa@kernel.org
>=20
> ---
> .../bpf/prog_tests/uprobe_multi_test.c | 213 ++++++++++++++++++
> .../bpf/progs/uprobe_multi_consumers.c | 39 ++++
> 2 files changed, 252 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consume=
rs.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index e6255d4df81d..27708110ea20 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -6,6 +6,7 @@
> #include "uprobe_multi.skel.h"
> #include "uprobe_multi_bench.skel.h"
> #include "uprobe_multi_usdt.skel.h"
> +#include "uprobe_multi_consumers.skel.h"
> #include "bpf/libbpf_internal.h"
> #include "testing_helpers.h"
> #include "../sdt.h"
> @@ -731,6 +732,216 @@ static void test_link_api(void)
> __test_link_api(child);
> }
>=20

[...]

> +
> +static void consumer_test(struct uprobe_multi_consumers skel,
> + unsigned long before, unsigned long after)
> +{
> + int err, idx;
> +
> + printf("consumer_test before %lu after %lu\n", before, after);
> +
> + / 'before' is each, we attach uprobe for every set idx */
> + for (idx =3D 0; idx < 4; idx++) {
> + if (test_bit(idx, before)) {
> + if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_before"))
> + goto cleanup;
> + }
> + }
> +
> + err =3D uprobe_consumer_test(skel, before, after);
> + if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
> + goto cleanup;
> +
> + for (idx =3D 0; idx < 4; idx++) {
> + const char fmt =3D "BUG";
> + __u64 val =3D 0;
> +
> + if (idx < 2) {
> + /
> + * uprobe entry
> + * +1 if define in 'before'
> + /
> + if (test_bit(idx, before))
> + val++;
> + fmt =3D "prog 0/1: uprobe";
> + } else {
> + /
> + * uprobe return is tricky ;-)
> + *
> + * to trigger uretprobe consumer, the uretprobe needs to be installed,
> + * which means one of the 'return' uprobes was alive when probe was hit:
> + *
> + * idxs: 2/3 uprobe return in 'installed' mask
> + *
> + * in addition if 'after' state removes everything that was installed in
> + * 'before' state, then uprobe kernel object goes away and return uprobe
> + * is not installed and we won't hit it even if it's in 'after' state.
> + */
> + unsigned long had_uretprobes =3D before & 0b1100; // is uretprobe insta=
lled
> + unsigned long probe_preserved =3D before & after; // did uprobe go away
> +
> + if (had_uretprobes && probe_preserved && test_bit(idx, after))
> + val++;
> + fmt =3D "idx 2/3: uretprobe";
> + }

Jiri, Andrii,

This test case started failing since upstream got merged into bpf-next,
starting from commit https://git.kernel.org/bpf/bpf-next/c/440b65232829

A snippet from the test log:

    consumer_test before 4 after 8
    uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
    consumer_test:PASS:uprobe_attach_before 0 nsec
    uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
    uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
    consumer_test:PASS:uprobe_consumer_test 0 nsec
    consumer_test:PASS:prog 0/1: uprobe 0 nsec
    consumer_test:PASS:prog 0/1: uprobe 0 nsec
    consumer_test:PASS:idx 2/3: uretprobe 0 nsec
    consumer_test:FAIL:idx 2/3: uretprobe unexpected idx 2/3: uretprobe: ac=
tual 1 !=3D expected 0
    consumer_test before 4 after 9
    uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
    consumer_test:PASS:uprobe_attach_before 0 nsec
    uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
    uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
    uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
    uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
    consumer_test:PASS:uprobe_consumer_test 0 nsec
    consumer_test:PASS:prog 0/1: uprobe 0 nsec
    consumer_test:PASS:prog 0/1: uprobe 0 nsec
    consumer_test:PASS:idx 2/3: uretprobe 0 nsec
    consumer_test:FAIL:idx 2/3: uretprobe unexpected idx 2/3: uretprobe: ac=
tual 1 !=3D expected 0
    consumer_test before 4 after 10
    uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
    consumer_test:PASS:uprobe_attach_before 0 nsec
    uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
    uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
    uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
    uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
    consumer_test:PASS:uprobe_consumer_test 0 nsec
    consumer_test:PASS:prog 0/1: uprobe 0 nsec
    consumer_test:PASS:prog 0/1: uprobe 0 nsec
    consumer_test:PASS:idx 2/3: uretprobe 0 nsec
    consumer_test:FAIL:idx 2/3: uretprobe unexpected idx 2/3: uretprobe: ac=
tual 1 !=3D expected 0


I couldn't figure out the reason as I have very shallow understanding
of what's happening in the test.

Jiri, could you please look into it?

I excluded this test from BPF CI for now.

Thank you!

> +
> + ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt);
>=20
> + skel->bss->uprobe_result[idx] =3D 0;
>=20
> + }
> +
> +cleanup:
> + for (idx =3D 0; idx < 4; idx++)
> + uprobe_detach(skel, idx);
> +}

[...]


