Return-Path: <bpf+bounces-18750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDB1820855
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 21:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19269283BE8
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06157C153;
	Sat, 30 Dec 2023 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="napURkiY"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928ABE65;
	Sat, 30 Dec 2023 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703966668; x=1704571468; i=markus.elfring@web.de;
	bh=FTeilRubP1fYfFWtCGepG3ruP3CzQnUY5rMrToXpVwE=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=napURkiYn207oOUROWDpZ1IYYasjASvR9bi+HcfbwPL6dfzyVbB0eHlfKeaOppuV
	 JK8NqVRCv4utfSfNnLkut6KVhfkzvXdbkNM+IycuHbTNtF/EpBRPGVb4DyPs8nVgn
	 UuWv+1Z3+c3WC0c6DLrw0+kXywQe3/wRN5z1h1/dFTbY77/Div+gtXC3sJALQletZ
	 ri2qnEd32vxCXX+GQ3NFYoOmTeaBSVItp7vByuejIgZ48s2f0Mg2vy42XId+O37d5
	 uy/R0p8GEymttG3oF0LlctHkV9NIIlkO/45fBJvWpw5ulWlGr7PYYYmtQqzR+JQOT
	 ynTW/VI9gC3SeZ1WlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbik-1r3mXt3IRC-00sj8F; Sat, 30
 Dec 2023 21:04:27 +0100
Message-ID: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de>
Date: Sat, 30 Dec 2023 21:04:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/5] bpf: Adjustments for four function implementations
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PryWHXlk/8JgTLBtJ4HVbwJ4e1P1AxGV7fML3Rs43AQwS7D9Ar0
 iotNBKkVvSym+9pGdXNIYQDcdBb1D3h4c+YhMp+lm9Z3AUyiIZ5uSNSG5nnXPxgb0JjdcKt
 fgdeWlcxgRIPYOcADNSHYXk0VqoTHwY/UP17m6+XfM6lmB/n1vV0hw9P0GdkD5HnCwbhB+l
 HQQAGHOVzHpktYBox+NZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e8rEjivcjJs=;QWyO0KQhoBajvmQgDgsosZOQ/Jb
 TAn+rL7NRQHPC2grVNz2U8iiMIy3nqteflmRxcLP6EBkA1IM4pj9a+i9wnQUwjE+haimfkzAO
 Z8h+g7+tMhyLu05/YaMS6X/9SiBYOkhStTRAnlEAi8jwnvRviKq8N7u0ddN/StrDMvxV7c3kF
 5gOQPeMg5N2MCrNIyWBt5NW9jiqY1hWDxEkhWgE+qhMHU+Be9Baa19YnAXU6+HKaIgw6XoCoY
 cuah2wn3ZnRWJgRRQOU1ZZwxLmHdTx/h8it30kQAxb2A3kz7kmu+/iQVOagK0EQsOrEyVb9TO
 kwJgrSRZC9F5reLQ7XPPUkdvlUzhvNZjL2CIStCtPZ2pt5G2YMeLP3AgFPRC4FDlFT7DN9Rhk
 JaoGt1NgQHRj2NAz4j2TAwnlXA+YVJSd6yUtGWWWxT7UX2IW41hcfer7GNorEVaMl2ODy3d/b
 HLE6zgO6tmF+sWfr9kCGminNHk+7f4EP+zmzMbItGQXEuN0avlG88LaqDfJgSjRwr87pom++g
 2/6KXjCJAn7AW+liuK9CRUYvJXN7LFGO/k4UAPwaGcrnwvuQZmcMK4TI7BjDGr2knEGWdx8rm
 yobMd1xN6L7fejE9Na+4kDmzcmQv7RxRpLW/cSdSgJbrqmSFut9aXRq9/RlW63IQSggiBCR6h
 CoSFNgb/isMAkxtIgAS4MTIdWLvrhYlfN7tSziYu2xxVWfO5/C7A9v79Kg9qNucdFFqwOcz1o
 OEGk0dM2UKEJGu9e+WWr8J6v1/vw+69Rveb4moaSoamgT9sd3prKRU53z4U7NGnvDWNtIW2h0
 SLP8C7vJyCpjD3/WXWhzn/q/w/b7s8z3EhMFcRFp6Q18QWy6Ih7efEP32EJNluP3BQSiAuUrY
 X7xbi6fkkphQ6DDtBZqzINgu4CiJOjdYochUea2PP8XWOlJmOaOdXHuATUGg2ErZZ37mi0gm0
 /xJ3qw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 30 Dec 2023 20:51:23 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Improve exception handling in bpf_struct_ops_link_create()
  Move an assignment for the variable =E2=80=9Cst_map=E2=80=9D
    in bpf_struct_ops_link_create()
  Improve exception handling in bpf_core_apply()
  Return directly after a failed bpf_map_kmalloc_node()
    in bpf_cgroup_storage_alloc()
  Improve exception handling in trie_update_elem()

 kernel/bpf/bpf_struct_ops.c | 12 ++++++------
 kernel/bpf/btf.c            |  8 +++++---
 kernel/bpf/local_storage.c  |  2 +-
 kernel/bpf/lpm_trie.c       | 24 +++++++++++-------------
 4 files changed, 23 insertions(+), 23 deletions(-)

=2D-
2.43.0


