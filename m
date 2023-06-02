Return-Path: <bpf+bounces-1731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C0720973
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 21:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C11C211EF
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1621DDE8;
	Fri,  2 Jun 2023 19:02:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092E1B912
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 19:02:07 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD11A5;
	Fri,  2 Jun 2023 12:02:02 -0700 (PDT)
Date: Fri, 02 Jun 2023 19:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rhysre.net;
	s=protonmail2; t=1685732519; x=1685991719;
	bh=C2QS5bMur8OIlVMgvGAIQpVXbcN3hut2o7OYj0Ps85k=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hb1jDB12okjd1GZPt82WIops7vdBFZLmoGanTrvn0AQXNw8UwPZZsqoadYEZA1D+1
	 04dPtrzURPVLfxxuKC+dPw+9n1OdWyYhxyv5+tmU4BNExSY7ydzBN0Crd/AaVJC+nc
	 y4cewhTe2f/3qQSFIM8azsahfLh127MGHk0LKbf5IFbBxjPPb53S287UzpTph+wOmj
	 emHg9gU5Jk/oM9EOlhTjat17Ny4sIS/3aC4HrSs7lDAXEJKridxySVcWOYoLpIW5bd
	 JJjc4HRYyKmxa8hmC3E4kshtfn5QnU0EFXmgNy+7dULUerUsmgdVo+RNsFEKvqb3sW
	 1dk8ZGwzxVzMA==
From: Rhys Rustad-Elliott <me@rhysre.net>
Cc: Rhys Rustad-Elliott <me@rhysre.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/2] Fix elem_size not being set for inner maps
Message-ID: <20230602190110.47068-1-me@rhysre.net>
Feedback-ID: 51368404:user:proton
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit d937bc3449fa ("bpf: make uniform use of array->elem_size
everywhere in arraymap.c") changed array_map_gen_lookup to use
array->elem_size instead of round_up(map->value_size, 8) as the element
size when generating code to access a value in an array map.

array->elem_size, however, is not set by bpf_map_meta_alloc when
initializing an BPF_MAP_TYPE_ARRAY_OF_MAPS or BPF_MAP_TYPE_HASH_OF_MAPS.
This results in array_map_gen_lookup incorrectly outputting code that
always accesses index 0 in the array (as the index will be calculated
via a multiplication with the element size, which is incorrectly set to
0).

This patchset sets elem_size on the bpf_array object when allocating an
array or hash of maps to fix this and adds a selftest that accesses an
array map nested within a hash of maps at a nonzero index to prevent
regressions.

v1: https://lore.kernel.org/bpf/95b5da7c-ee52-3ecb-0a4e-f6a7a114f269@linux.=
dev/

Changelog:

v1 -> v2:

Address comments by Martin KaFai Lau:
- Directly use inner_array->elem_size instead of using round_up
- Move selftests to a new patch
- Use ASSERT_* macros instead of CHECK and remove duration
- Remove unnecessary usleep
- Shorten selftest name

Rhys Rustad-Elliott (2):
  bpf: Fix elem_size not being set for inner maps
  selftests/bpf: Add access_inner_map selftest

 kernel/bpf/map_in_map.c                       |  8 +++-
 .../bpf/prog_tests/inner_array_lookup.c       | 31 +++++++++++++
 .../bpf/progs/test_inner_array_lookup.c       | 45 +++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/inner_array_look=
up.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_inner_array_look=
up.c

--=20
2.40.1



