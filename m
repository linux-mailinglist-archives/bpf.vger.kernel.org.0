Return-Path: <bpf+bounces-60822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82883ADD121
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC9C17738D
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECEB2E92BC;
	Tue, 17 Jun 2025 15:13:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778561EA7D2;
	Tue, 17 Jun 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173217; cv=none; b=doILDqYvztXTZCTmmISCufFfNIRFiaTICY7XthgzwhCIHTG3BTHD3JHZCxXZZHY0FwrLBMIh781iFHJ9DiB3gspHaZMJRyd7sCkY8hrsySJZA3bmWAo5jT3OWg7kJWZ4XP0fjoEK9ei14ICNkRBp/QvEl9gXK6Nhyl3zt2V/3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173217; c=relaxed/simple;
	bh=tlgpcwD9VxjkHm89DEDm1hJrTiiU6FF3SsCvRmkSzEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YO5qSPaK40x5qSOlIpfFN0hD/UIA9mbz0kbzU5Wn4cmcY7RI1Jptk0/n+ybKAkg0WjX1Qrym3LyrgPwN3ixqLrXOQLoJ2ik9PgmgrXeqI5SMnF5KHWKMpqbNNTg2gQiRJ/Vcltu+QdETxlQnlI6d6Xyr2u21RtA5cIegQP9VSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bM9Mg6ZFcz1HC0g;
	Tue, 17 Jun 2025 23:12:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3E7691402FC;
	Tue, 17 Jun 2025 23:13:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3reAWhlFohszeCQ--.567S2;
	Tue, 17 Jun 2025 16:13:31 +0100 (CET)
Message-ID: <c7a7c6b58563d30fec023716ff709952dbb4d75a.camel@huaweicloud.com>
Subject: Re: bpf: fix key serial argument of bpf_lookup_user_key()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 17 Jun 2025 17:13:22 +0200
In-Reply-To: <84cdb0775254d297d75e21f577089f64abdfbd28.camel@HansenPartnership.com>
References: 
	<84cdb0775254d297d75e21f577089f64abdfbd28.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD3reAWhlFohszeCQ--.567S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar48JrWfur17tr4DXr13urg_yoWxXFy7pa
	y8Ja9ayr1F9F4UXF17AF47Za1FgFnagw42kay8J343Ar1kt3s7Xr1xKF4YgwnI9rWFvrna
	vF1Ig34avr48X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBGhRE+QGkwABse

On Tue, 2025-06-17 at 10:57 -0400, James Bottomley wrote:
> The underlying lookup_user_key() function uses a signed 32 bit integer
> for key serial numbers because legitimate serial numbers are positive
> (and > 3) and keyrings are negative.  Using a u32 for the keyring in
> the bpf function doesn't currently cause any conversion problems but
> will start to trip the signed to unsigned conversion warnings when the
> kernel enables them, so convert the argument to signed (and update the
> tests accordingly) before it acquires more users.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Looks good from my side:

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
>  kernel/trace/bpf_trace.c                                  | 2 +-
>  tools/testing/selftests/bpf/bpf_kfuncs.h                  | 2 +-
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c         | 5 +++--
>  tools/testing/selftests/bpf/progs/test_lookup_key.c       | 4 ++--
>  tools/testing/selftests/bpf/progs/test_sig_in_xattr.c     | 2 +-
>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c | 2 +-
>  tools/testing/selftests/bpf/progs/verifier_ref_tracking.c | 2 +-
>  7 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 132c8be6f635..0a06ea6638fe 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1270,7 +1270,7 @@ __bpf_kfunc_start_defs();
>   * Return: a bpf_key pointer with a valid key pointer if the key is foun=
d, a
>   *         NULL pointer otherwise.
>   */
> -__bpf_kfunc struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
> +__bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
>  {
>  	key_ref_t key_ref;
>  	struct bpf_key *bkey;
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index 8215c9b3115e..9386dfe8b884 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -69,7 +69,7 @@ extern int bpf_get_file_xattr(struct file *file, const =
char *name,
>  			      struct bpf_dynptr *value_ptr) __ksym;
>  extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr =
*digest_ptr) __ksym;
> =20
> -extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __=
ksym;
> +extern struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) __=
ksym;
>  extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
>  extern void bpf_key_put(struct bpf_key *key) __ksym;
>  extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
> index 43637ee2cdcd..3a868a199349 100644
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> @@ -16,10 +16,11 @@ struct {
>  	__type(value, long);
>  } map_a SEC(".maps");
> =20
> -__u32 user_data, key_serial, target_pid;
> +__u32 user_data, target_pid;
> +__s32 key_serial;
>  __u64 flags, task_storage_val, cgroup_id;
> =20
> -struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
> +struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) __ksym;
>  void bpf_key_put(struct bpf_key *key) __ksym;
>  void bpf_rcu_read_lock(void) __ksym;
>  void bpf_rcu_read_unlock(void) __ksym;
> diff --git a/tools/testing/selftests/bpf/progs/test_lookup_key.c b/tools/=
testing/selftests/bpf/progs/test_lookup_key.c
> index cdbbb12f1491..1f7e1e59b073 100644
> --- a/tools/testing/selftests/bpf/progs/test_lookup_key.c
> +++ b/tools/testing/selftests/bpf/progs/test_lookup_key.c
> @@ -14,11 +14,11 @@
>  char _license[] SEC("license") =3D "GPL";
> =20
>  __u32 monitored_pid;
> -__u32 key_serial;
> +__s32 key_serial;
>  __u32 key_id;
>  __u64 flags;
> =20
> -extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __=
ksym;
> +extern struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) __=
ksym;
>  extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
>  extern void bpf_key_put(struct bpf_key *key) __ksym;
> =20
> diff --git a/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c b/tool=
s/testing/selftests/bpf/progs/test_sig_in_xattr.c
> index 8ef6b39335b6..34b30e2603f0 100644
> --- a/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
> +++ b/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
> @@ -40,7 +40,7 @@ char digest[MAGIC_SIZE + SIZEOF_STRUCT_FSVERITY_DIGEST =
+ SHA256_DIGEST_SIZE];
>  __u32 monitored_pid;
>  char sig[MAX_SIG_SIZE];
>  __u32 sig_size;
> -__u32 user_keyring_serial;
> +__s32 user_keyring_serial;
> =20
>  SEC("lsm.s/file_open")
>  int BPF_PROG(test_file_open, struct file *f)
> diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/=
tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> index e96d09e11115..ff8d755548b9 100644
> --- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> @@ -17,7 +17,7 @@
>  #define MAX_SIG_SIZE 1024
> =20
>  __u32 monitored_pid;
> -__u32 user_keyring_serial;
> +__s32 user_keyring_serial;
>  __u64 system_keyring_id;
> =20
>  struct data {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/=
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
> index 683a882b3e6d..910365201f68 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
> @@ -27,7 +27,7 @@ struct bpf_key {} __attribute__((preserve_access_index)=
);
> =20
>  extern void bpf_key_put(struct bpf_key *key) __ksym;
>  extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
> -extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __=
ksym;
> +extern struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) __=
ksym;
> =20
>  /* BTF FUNC records are not generated for kfuncs referenced
>   * from inline assembly. These records are necessary for


