Return-Path: <bpf+bounces-55919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA90A89256
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 04:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4517709F
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 02:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB842DFA51;
	Tue, 15 Apr 2025 02:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dXeHb6PQ"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD549659;
	Tue, 15 Apr 2025 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685634; cv=none; b=UGKYEz4eEWdwpJAIhT5w4UD7dYAE3QpRitD5a8d5VD43410X2/QalBFngowUeGGIeiyDSntikHuTU2K/U6mQjpNRoYqtC+rhlryf8sq1Un8Jbp5J/hFe/Kio6+3VW8jo8vduT75Fq6ywuGzqdziF8cIShE5HavQxCLJSYvShus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685634; c=relaxed/simple;
	bh=Akoo9jqkEcWSXg3tee0G2D4BiWk0o+iDka8f4zLXeJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyEJ5Ub4mt/c4aln+lzihj2zHV95DxWJhbdnHofUuX402oubOHyKgdu6XMJAS8GmLKGkIfuYwIlZnY4NdgWB/ikE5Yx/MND6k4CJqSz26l//r9qFg64sHqaPV92tdc7Fs3x2LRpmMsw56nPKdr1/mFxf0oWfUAIBexbGRb2DFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dXeHb6PQ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NHKWS
	zLsBAbsyzeKkgznnnIP2bOgjZf3BsRST3FJzLs=; b=dXeHb6PQiUhO6v42Dg937
	J8Jc8v1qCS8Um9lRDAFraRCYmw9z1oFbrmA4rs9diQf29AH8FCDh2It52gLfGdXS
	oGVewM4NsNeuiUCOZr7fPw33xoXLwNMKJrRNbEDTEQqjemZQQNhBq76a4/e9wgv3
	s55fHy52adF1qmNJYIjSdc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAH8p8Iyv1nVOGLGQ--.29463S2;
	Tue, 15 Apr 2025 10:52:58 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: olsajiri@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	hengqi.chen@gmail.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Add test for attaching kprobe with long event names
Date: Tue, 15 Apr 2025 10:52:26 +0800
Message-Id: <20250415025226.49891-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Z_z161cpsaR2uQm3@krava>
References: <Z_z161cpsaR2uQm3@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH8p8Iyv1nVOGLGQ--.29463S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw4fXr1xZrykXw4fXr1DWrg_yoW7CFW5pa
	yDZr1YkFs5X3W7XFy7J3y5Zr4Fvrn3Zr17CF1DtF98ZF4kZw18XF1xtF4avwn5GrZav3W3
	Zw40qr9xu34xXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUDxhQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiThIweGf9xgaragAAsP

On Mon, 14 Apr 2025 13:47:55 +0200, Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Apr 14, 2025 at 05:34:02PM +0800, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> > 
> > This test verifies that attaching kprobe/kretprobe with long event names
> > does not trigger EINVAL errors.
> > 
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> >  .../selftests/bpf/prog_tests/attach_probe.c   | 35 +++++++++++++++++++
> >  .../selftests/bpf/test_kmods/bpf_testmod.c    |  5 +++
> >  .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 ++
> >  3 files changed, 42 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > index 9b7f36f39c32..633b5eb4379b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > @@ -168,6 +168,39 @@ static void test_attach_uprobe_long_event_name(void)
> >  	test_attach_probe_manual__destroy(skel);
> >  }
> >  
> > +/* attach kprobe/kretprobe long event name testings */
> > +static void test_attach_kprobe_long_event_name(void)
> > +{
> > +	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> > +	struct bpf_link *kprobe_link, *kretprobe_link;
> > +	struct test_attach_probe_manual *skel;
> > +
> > +	skel = test_attach_probe_manual__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> > +		return;
> > +
> > +	/* manual-attach kprobe/kretprobe */
> > +	kprobe_opts.attach_mode = PROBE_ATTACH_MODE_LEGACY;
> > +	kprobe_opts.retprobe = false;
> > +	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
> > +						      "bpf_kfunc_looooooooooooooooooooooooooooooong_name",
> > +						      &kprobe_opts);
> > +	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_long_event_name"))
> > +		goto cleanup;
> > +	skel->links.handle_kprobe = kprobe_link;
> > +
> > +	kprobe_opts.retprobe = true;
> > +	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
> > +							 "bpf_kfunc_looooooooooooooooooooooooooooooong_name",
> > +							 &kprobe_opts);
> > +	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_long_event_name"))
> > +		goto cleanup;
> > +	skel->links.handle_kretprobe = kretprobe_link;
> > +
> > +cleanup:
> > +	test_attach_probe_manual__destroy(skel);
> > +}
> > +
> >  static void test_attach_probe_auto(struct test_attach_probe *skel)
> >  {
> >  	struct bpf_link *uprobe_err_link;
> > @@ -371,6 +404,8 @@ void test_attach_probe(void)
> >  
> >  	if (test__start_subtest("uprobe-long_name"))
> >  		test_attach_uprobe_long_event_name();
> > +	if (test__start_subtest("kprobe-long_name"))
> > +		test_attach_kprobe_long_event_name();
> >  
> >  cleanup:
> >  	test_attach_probe__destroy(skel);
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index f38eaf0d35ef..439f6c2b2456 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > @@ -1053,6 +1053,10 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
> >  	return args->a;
> >  }
> >  
> > +__bpf_kfunc void bpf_kfunc_looooooooooooooooooooooooooooooong_name(void)
> > +{
> > +}
> 
> does it need to be a kfunc? IIUC it just needs to be a normal kernel/module function
> 
> jirka
> 

Indeed, so is it okay if I make the following modifications:

--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -134,6 +134,10 @@ bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline void bpf_testmod_looooooooooooooooooooooooooooooong_name(void)
+{
+}
+
 __bpf_kfunc void
 bpf_testmod_test_mod_kfunc(int i)

Thanks.

> > +
> >  BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
> >  BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
> >  BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> > @@ -1093,6 +1097,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABL
> >  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
> > +BTF_ID_FLAGS(func, bpf_kfunc_looooooooooooooooooooooooooooooong_name)
> >  BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
> >  
> >  static int bpf_testmod_ops_init(struct btf *btf)
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > index b58817938deb..e5b833140418 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > @@ -159,4 +159,6 @@ void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
> >  void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
> >  void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
> >  
> > +void bpf_kfunc_looooooooooooooooooooooooooooooong_name(void) __ksym;
> > +
> >  #endif /* _BPF_TESTMOD_KFUNC_H */
> > -- 
> > 2.43.0
> > 


