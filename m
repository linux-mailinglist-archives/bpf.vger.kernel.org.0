Return-Path: <bpf+bounces-55918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E148BA891B9
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 04:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B341A189C3FB
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D5C161310;
	Tue, 15 Apr 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Iz8u20+O"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51122DFA3B;
	Tue, 15 Apr 2025 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682536; cv=none; b=Z17xjpwwZUldgvmqraX6gIHNReF54qHgUWUsVCtAZGxB1zLSXTpoIkeBYXfkTg6rPrwY1CEegfwji0f17ppunriE1d/9R9MFuzE5fY7/0Gvj7l+ruOXZe1mcm152HVBaXOUCnOAp1h5DlN2mM27Aq/SbpSi2gFFZg+PIq8QnhIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682536; c=relaxed/simple;
	bh=U7t9nA21JGw2dEj6klZs5Ynjd7/8AjiE9+hqAxg1odk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2PlKw8u/cR0RcdVP7H2Jnmta1twnTqLpa+Kl0hrclni6WWUHZ8+ve034EJdcGeiew2rXeMF4o0fq3Cn+yOuJYrkm3n42l0EAVfFyI0WRi0lvY3aFxXrzLDAXFOfDek2gjNhePRcBcrrlzZ6uh4E1o8MvT9CLbboOb8LEYSXd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Iz8u20+O; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9hkWe
	q/VxV+O58HqndGEkufimFjxKtOCASpcTil7Loc=; b=Iz8u20+OWWPfzCB5Nof84
	0ZjWVEW42hVYiakCLtSsqPTT2Ay/22rbcMouzfQ3Wr+7M7a2FnWBOu+2Mwz48mAe
	sVDS5+99A0IAHgzgPnkItLr+QOFCVAIFa3NN51WOMzp08yWs0GtitGb7g2kArK7a
	Ph+rNb5027gLNmP00jcM9c=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAX7wT0vf1nh27NAQ--.14S2;
	Tue, 15 Apr 2025 10:01:26 +0800 (CST)
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
Subject: Re: [PATCH v3 bpf-next 1/3] libbpf: Fix event name too long error
Date: Tue, 15 Apr 2025 10:01:15 +0800
Message-Id: <20250415020115.35450-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Z_z06uND92kzrXfJ@krava>
References: <Z_z06uND92kzrXfJ@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAX7wT0vf1nh27NAQ--.14S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF1fZFyxJF1xuFW7trWUJwb_yoW7KFW8pF
	4DZrn0yF4ftay29F9Iqw18Z3409w4kJF4UJr1Dtr98ZF48WF4DAa42kF4DC3Z8XrZ29w13
	Za1jgry3XFyxAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUDxhQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgsweGf9vXsZZgAAsi

On Mon, 14 Apr 2025 13:43:38 +0200 Jiri Olsa <olsajiri@gmail.com> wrote:
> On Mon, Apr 14, 2025 at 05:34:00PM +0800, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> > 
> > When the binary path is excessively long, the generated probe_name in libbpf
> > exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> > This causes legacy uprobe event attachment to fail with error code -22.
> > 
> > Before Fix:
> > 	./test_progs -t attach_probe/kprobe-long_name
> > 	......
> > 	libbpf: failed to add legacy kprobe event for 'bpf_kfunc_looooooooooooooooooooooooooooooong_name+0x0': -EINVAL
> > 	libbpf: prog 'handle_kprobe': failed to create kprobe 'bpf_kfunc_looooooooooooooooooooooooooooooong_name+0x0' perf event: -EINVAL
> > 	test_attach_kprobe_long_event_name:FAIL:attach_kprobe_long_event_name unexpected error: -22
> > 	test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
> > 	#13/11   attach_probe/kprobe-long_name:FAIL
> > 	#13      attach_probe:FAIL
> > 
> > 	./test_progs -t attach_probe/uprobe-long_name
> > 	......
> > 	libbpf: failed to add legacy uprobe event for /root/linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9: -EINVAL
> > 	libbpf: prog 'handle_uprobe': failed to create uprobe '/root/linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9' perf event: -EINVAL
> > 	test_attach_uprobe_long_event_name:FAIL:attach_uprobe_long_event_name unexpected error: -22
> > 	#13/10   attach_probe/uprobe-long_name:FAIL
> > 	#13      attach_probe:FAIL
> > After Fix:
> > 	./test_progs -t attach_probe/uprobe-long_name
> > 	#13/10   attach_probe/uprobe-long_name:OK
> > 	#13      attach_probe:OK
> > 	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > 	./test_progs -t attach_probe/kprobe-long_name
> > 	#13/11   attach_probe/kprobe-long_name:OK
> > 	#13      attach_probe:OK
> > 	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
> > Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> >  tools/lib/bpf/libbpf.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b2591f5cab65..9e047641e001 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -60,6 +60,8 @@
> >  #define BPF_FS_MAGIC		0xcafe4a11
> >  #endif
> >  
> > +#define MAX_EVENT_NAME_LEN	64
> > +
> >  #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
> >  
> >  #define BPF_INSN_SZ (sizeof(struct bpf_insn))
> > @@ -11142,10 +11144,10 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> >  	static int index = 0;
> >  	int i;
> >  
> > -	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
> > -		 __sync_fetch_and_add(&index, 1));
> > +	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> > +		 __sync_fetch_and_add(&index, 1), kfunc_name, offset);
> 
> so the fix is to move unique id before kfunc_name to make sure it gets
> to the event name right? would be great to have it in changelog
> 

Yes, defining MAX_EVENT_NAME_LEN ensures event names are truncated via snprintf
to prevent exceeding the maximum length limit.
Moving the unique id before kfunc_name avoids truncating the id.
Regarding the changelog: Should this information go into the commit message of the patch, or somewhere else?

> 
> >  
> > -	/* sanitize binary_path in the probe name */
> > +	/* sanitize kfunc_name in the probe name */
> >  	for (i = 0; buf[i]; i++) {
> >  		if (!isalnum(buf[i]))
> >  			buf[i] = '_';
> > @@ -11270,7 +11272,7 @@ int probe_kern_syscall_wrapper(int token_fd)
> >  
> >  		return pfd >= 0 ? 1 : 0;
> >  	} else { /* legacy mode */
> > -		char probe_name[128];
> > +		char probe_name[MAX_EVENT_NAME_LEN];
> >  
> >  		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
> >  		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
> > @@ -11328,7 +11330,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> >  					    func_name, offset,
> >  					    -1 /* pid */, 0 /* ref_ctr_off */);
> >  	} else {
> > -		char probe_name[256];
> > +		char probe_name[MAX_EVENT_NAME_LEN];
> >  
> >  		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
> >  					     func_name, offset);
> > @@ -11878,9 +11880,12 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
> >  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> >  					 const char *binary_path, uint64_t offset)
> >  {
> > +	static int index = 0;
> >  	int i;
> >  
> > -	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path, (size_t)offset);
> > +	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> > +		 __sync_fetch_and_add(&index, 1),
> > +		 basename((void *)binary_path), (size_t)offset);
> 
> gen_kprobe_legacy_event_name and gen_uprobe_legacy_event_name seem to
> be identical now, maybe we can have just one ?
> 
> thanks,
> jirka
> 

The gen_uprobe_legacy_event_name function includes an extra basename compared to gen_kprobe_legacy_event_name,
as the prefixes of binary_path are often too similar to distinguish easily.
When merging these two into a single function, is it acceptable to pass basename((void *)binary_path)
directly during the uprobe invocation, or should we remove the addition of basename? Thank you!

> >  
> >  	/* sanitize binary_path in the probe name */
> >  	for (i = 0; buf[i]; i++) {
> > @@ -12312,7 +12317,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >  		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
> >  					    func_offset, pid, ref_ctr_off);
> >  	} else {
> > -		char probe_name[PATH_MAX + 64];
> > +		char probe_name[MAX_EVENT_NAME_LEN];
> >  
> >  		if (ref_ctr_off)
> >  			return libbpf_err_ptr(-EINVAL);
> > -- 
> > 2.43.0
> > 


