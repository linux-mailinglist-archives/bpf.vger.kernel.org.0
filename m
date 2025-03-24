Return-Path: <bpf+bounces-54605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270A1A6D93A
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD9C167959
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C325DD1E;
	Mon, 24 Mar 2025 11:36:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA51E633C
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816190; cv=none; b=HpMtwC2x0shyi0CBCsUtmSS6Yf9xFyd7bD/ulzlaxayenkNLvo8MlPpH2MVmf0gFfjgqUUOVpTAQe3Xwt8CTwpaWS8rZkm3xEeuEdnB7G0rDjoLSCLfC+XB7SCSZ2ytUtEkxODj4ku4GzWdMtVBOBqh8Cta3XZvPBbGnUn8OoCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816190; c=relaxed/simple;
	bh=+Tvq4qW+EPI6ctmJ0WkfZjIYhyNCmSByQ9nYSxayTjo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i8BYrLRLFLtDLMOLOEVRhfME0bJxLdIMNi/mLH3vbA/MEUu0zdjKyGeKkpED3YC8Ib83I4WzibK2t0bAaX4dkWT+pp37wvhrs/fi9CBfI2+1icp27jFo7g7odtA7MiN9MNfr0Izfz+nPM2UaD7ZWVd2VrsD83E9FMIMmKurTEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZLrbS61rgz4f3jtF
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 19:36:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 524501A1028
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 19:36:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3F8KyQ+Fnx1BLHQ--.31942S2;
	Mon, 24 Mar 2025 19:36:20 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 0/6] bpf: Support atomic update for htab of
 maps
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 Zvi Effron <zeffron@riotgames.com>, Cody Haas <chaas@riotgames.com>,
 Hou Tao <houtao@huaweicloud.com>
References: <20250308135110.953269-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <04a2b00d-970f-7357-81e3-509a543550e9@huaweicloud.com>
Date: Mon, 24 Mar 2025 19:36:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250308135110.953269-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3F8KyQ+Fnx1BLHQ--.31942S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWkCFWkKw17JFy5WF1rZwb_yoW8Aw4xpa
	yI9FW3Kr1ktFnFvw4fGw429F4rJ3Z7tr1xA3ZFqry5Cw48tFyxXr1xKF4YkrZ3JrWruryr
	Zr17KrZxC34vvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

ping ?

On 3/8/2025 9:51 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The motivation for the patch set comes from the question raised by Cody
> Haas [1]. When trying to concurrently lookup and update an existing
> element in a htab of maps, the lookup procedure may return -ENOENT
> unexpectedly. The first revision of the patch set tried to resolve the
> problem by making the insertion of the new element and the deletion of
> the old element being atomic from the perspective of the lookup process.
> While the solution would benefit all hash maps, it does not fully
> resolved the problem due to the immediate reuse issue. Therefore, in v2
> of the patch set, it only fixes the problem for fd htab.
>
> Please see individual patches for details. Comments are always welcome.
>
> v2:
>   * only support atomic update for fd htab
>
> v1: https://lore.kernel.org/bpf/20250204082848.13471-1-hotforest@gmail.com
>
> [1]: https://lore.kernel.org/xdp-newbies/CAH7f-ULFTwKdoH_t2SFc5rWCVYLEg-14d1fBYWH2eekudsnTRg@mail.gmail.com/
>
> Hou Tao (6):
>   bpf: Factor out htab_elem_value helper()
>   bpf: Rename __htab_percpu_map_update_elem to
>     htab_map_update_elem_in_place
>   bpf: Support atomic update for htab of maps
>   bpf: Add is_fd_htab() helper
>   bpf: Don't allocate per-cpu extra_elems for fd htab
>   selftests/bpf: Add test case for atomic update of fd htab
>
>  kernel/bpf/hashtab.c                          | 148 +++++++-------
>  .../selftests/bpf/prog_tests/fd_htab_lookup.c | 192 ++++++++++++++++++
>  .../selftests/bpf/progs/fd_htab_lookup.c      |  25 +++
>  3 files changed, 289 insertions(+), 76 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fd_htab_lookup.c
>


