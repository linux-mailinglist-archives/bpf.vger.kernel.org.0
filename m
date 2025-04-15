Return-Path: <bpf+bounces-55924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D07A894C5
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9AE3B7B7D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715B279911;
	Tue, 15 Apr 2025 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l926/ykz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65082750FA;
	Tue, 15 Apr 2025 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701629; cv=none; b=IyIh7+8H5xoHuAgNoIZXETYFRASCbwkxVu4Uuyq23L69UKZkXIvzsmV2TmrlsEPHuvB2jGmY9sLOKOX9InvvrLyiwcrKjUyGBqWf62bXT5pRpprQ/xga88FCMpEdSMrOiI6rzwabaMvrJVCt7wgcESjpLiJNaPSUDcNOyyhn/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701629; c=relaxed/simple;
	bh=J8YPYvP36v77bLaXgHvQ+esm3mH2SEYCO8QCqTRTyK0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TevCYU2LsPMxMYnKcPbtbWSjdMlbvh1M5y68wVwUTa4wRs0MkL+yexiL48KxAcex83FvevIUW7rJVOylDpRuyizoBWGH0Vx7P4C+Gwjtl3fZnXkqFPJzVx3ksa8u5CCayzJt2am9CAKWdDlkj5kT3ZJhxEh6WhyDFTXhqtFmWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l926/ykz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c0dfba946so3704063f8f.3;
        Tue, 15 Apr 2025 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744701626; x=1745306426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4QG/01zstO6eevpGSLQRgfwXCiCDzuqT7ZdvEe+JuI=;
        b=l926/ykzzmLt8JKkgPCfiszVa1Tf2e8XtlE7fTvJfeb5mXNvKCSvF3wacJIaN8t8Pq
         k3lMj84zD1k5WgfNFU/W//5FvwSU76uICLe4xKCUpgEi/tody+8RUPwvEGTTrXlszGae
         sfS61mqL8q6fFl/A0TwJKaOftHtsfO+/IIzDXPUj/gk61+YH/H2FxGdiq4CfSRRYPdMW
         OyqjLacprpXdRpLTbV+riVRjYJOXGghQN61cWrmrh9CKyA78kIglPxs5gFAbyjrzUmZE
         cJ9SXIS4OMwcqI5iT1KlH0YGKzF3J7EtrR5RBE2n1x13o9REianlhIotLrBcmhmr29Jn
         aBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701626; x=1745306426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4QG/01zstO6eevpGSLQRgfwXCiCDzuqT7ZdvEe+JuI=;
        b=BR8Yz6w2O0Ehppbe/JOfuHd/853aUi5vxjKWFSjbxnoKKGdTDWHkIJQ4IAuNtecaoG
         o4Uw9RGe9AoaWA/FT1mhReqZeA0sRoH8e37f4Hcp3RDkwc/uor56abfTZ5UBkFAUGP7v
         gkoeWTp3RzPdomJvGZmGWvqk+Qy0NZOGvlcLTe+wXvUXpN1Ga4TXcINJr44/o2TaA7kM
         lr59XICg5USmX10lHcp24P0fTxUA/l8t/1svGkDy+ayTcIz7q3sA5gmRGbmKLPDE9yTc
         eXGFYsUKjNV1tDlSSpqI0vkrBJTA2mrI0AgNmcMXgxvkoFqyVE/742iFNCWX+l0FbK5o
         fcCg==
X-Forwarded-Encrypted: i=1; AJvYcCWl7pnZJFZyliK11bHhoSuM2bNmLn/138sXzrPOV4alNuoYqfcTDPMScAXPGLX22zygpdWfoYcubAYUTbhY@vger.kernel.org, AJvYcCXUJxl7RStkj8xxtm53foIKsjLBsTIqlBc3sYh096n4WYGbnQC1EhIJ2OwlECfHF1gsgv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqmijAazsbE4HeZZHJDUktpXIm/TKtxm2HOTv63zw9CPGAA7k
	K4TXQpTAtswC2mMYQggOa946tTmuJBCrs9gOHHGOPFCy9hA+yAOT
X-Gm-Gg: ASbGnct2JF+ohF3NtyJJu3VEr7JIfl2SXLt0+m0KJ3ThVzcAW13jYzabpQO5d9/j6to
	77MgJ7EFi/PqoTlSsrTFzhv3mKnaWR5dK/OAhLuy3Sshrz/SCXSO4B3rfD/0Ec8B4XRagiCUOa5
	OB8sP5vDbJS9SFNVn7nsK07ev5kcp0mJmVtp+OZuUXGYgRuX5DxGkIfNvLgVmeHCokqMmD7Az7C
	7nV7ViNali/D6d3qL6TmsPiR2aAcaTg6hYdFZH/p8n8pOF484921xyXNig7RySynLN8M3XBlErL
	VM1B0S6xeZT3aZ324xvXV5jgRnfnTHxc
X-Google-Smtp-Source: AGHT+IGXCVr7yO7ZMbLc/fUL/TDFBLuAMMxEfIFNm2wq93JgrNW/jErA+gpk2+Mc+WaBJSAqUM0Weg==
X-Received: by 2002:a05:6000:4313:b0:39c:1257:c96f with SMTP id ffacd0b85a97d-39eaaecdc09mr13306254f8f.59.1744701625879;
        Tue, 15 Apr 2025 00:20:25 -0700 (PDT)
Received: from krava ([2a00:102a:4000:cc7a:6dc3:41c:f241:1598])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445708sm13433737f8f.96.2025.04.15.00.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:20:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 15 Apr 2025 09:20:22 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: olsajiri@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	haoluo@google.com, hengqi.chen@gmail.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 1/3] libbpf: Fix event name too long error
Message-ID: <Z_4Itg5H7-410o4d@krava>
References: <Z_z06uND92kzrXfJ@krava>
 <20250415020115.35450-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415020115.35450-1-yangfeng59949@163.com>

On Tue, Apr 15, 2025 at 10:01:15AM +0800, Feng Yang wrote:
> On Mon, 14 Apr 2025 13:43:38 +0200 Jiri Olsa <olsajiri@gmail.com> wrote:
> > On Mon, Apr 14, 2025 at 05:34:00PM +0800, Feng Yang wrote:
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > > 
> > > When the binary path is excessively long, the generated probe_name in libbpf
> > > exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> > > This causes legacy uprobe event attachment to fail with error code -22.
> > > 
> > > Before Fix:
> > > 	./test_progs -t attach_probe/kprobe-long_name
> > > 	......
> > > 	libbpf: failed to add legacy kprobe event for 'bpf_kfunc_looooooooooooooooooooooooooooooong_name+0x0': -EINVAL
> > > 	libbpf: prog 'handle_kprobe': failed to create kprobe 'bpf_kfunc_looooooooooooooooooooooooooooooong_name+0x0' perf event: -EINVAL
> > > 	test_attach_kprobe_long_event_name:FAIL:attach_kprobe_long_event_name unexpected error: -22
> > > 	test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
> > > 	#13/11   attach_probe/kprobe-long_name:FAIL
> > > 	#13      attach_probe:FAIL
> > > 
> > > 	./test_progs -t attach_probe/uprobe-long_name
> > > 	......
> > > 	libbpf: failed to add legacy uprobe event for /root/linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9: -EINVAL
> > > 	libbpf: prog 'handle_uprobe': failed to create uprobe '/root/linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9' perf event: -EINVAL
> > > 	test_attach_uprobe_long_event_name:FAIL:attach_uprobe_long_event_name unexpected error: -22
> > > 	#13/10   attach_probe/uprobe-long_name:FAIL
> > > 	#13      attach_probe:FAIL
> > > After Fix:
> > > 	./test_progs -t attach_probe/uprobe-long_name
> > > 	#13/10   attach_probe/uprobe-long_name:OK
> > > 	#13      attach_probe:OK
> > > 	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > 	./test_progs -t attach_probe/kprobe-long_name
> > > 	#13/11   attach_probe/kprobe-long_name:OK
> > > 	#13      attach_probe:OK
> > > 	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
> > > Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index b2591f5cab65..9e047641e001 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -60,6 +60,8 @@
> > >  #define BPF_FS_MAGIC		0xcafe4a11
> > >  #endif
> > >  
> > > +#define MAX_EVENT_NAME_LEN	64
> > > +
> > >  #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
> > >  
> > >  #define BPF_INSN_SZ (sizeof(struct bpf_insn))
> > > @@ -11142,10 +11144,10 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> > >  	static int index = 0;
> > >  	int i;
> > >  
> > > -	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
> > > -		 __sync_fetch_and_add(&index, 1));
> > > +	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> > > +		 __sync_fetch_and_add(&index, 1), kfunc_name, offset);
> > 
> > so the fix is to move unique id before kfunc_name to make sure it gets
> > to the event name right? would be great to have it in changelog
> > 
> 
> Yes, defining MAX_EVENT_NAME_LEN ensures event names are truncated via snprintf
> to prevent exceeding the maximum length limit.
> Moving the unique id before kfunc_name avoids truncating the id.
> Regarding the changelog: Should this information go into the commit message of the patch, or somewhere else?

having this in changelog would help

> 
> > 
> > >  
> > > -	/* sanitize binary_path in the probe name */
> > > +	/* sanitize kfunc_name in the probe name */
> > >  	for (i = 0; buf[i]; i++) {
> > >  		if (!isalnum(buf[i]))
> > >  			buf[i] = '_';
> > > @@ -11270,7 +11272,7 @@ int probe_kern_syscall_wrapper(int token_fd)
> > >  
> > >  		return pfd >= 0 ? 1 : 0;
> > >  	} else { /* legacy mode */
> > > -		char probe_name[128];
> > > +		char probe_name[MAX_EVENT_NAME_LEN];
> > >  
> > >  		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
> > >  		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
> > > @@ -11328,7 +11330,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> > >  					    func_name, offset,
> > >  					    -1 /* pid */, 0 /* ref_ctr_off */);
> > >  	} else {
> > > -		char probe_name[256];
> > > +		char probe_name[MAX_EVENT_NAME_LEN];
> > >  
> > >  		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
> > >  					     func_name, offset);
> > > @@ -11878,9 +11880,12 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
> > >  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> > >  					 const char *binary_path, uint64_t offset)
> > >  {
> > > +	static int index = 0;
> > >  	int i;
> > >  
> > > -	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path, (size_t)offset);
> > > +	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> > > +		 __sync_fetch_and_add(&index, 1),
> > > +		 basename((void *)binary_path), (size_t)offset);
> > 
> > gen_kprobe_legacy_event_name and gen_uprobe_legacy_event_name seem to
> > be identical now, maybe we can have just one ?
> > 
> > thanks,
> > jirka
> > 
> 
> The gen_uprobe_legacy_event_name function includes an extra basename compared to gen_kprobe_legacy_event_name,
> as the prefixes of binary_path are often too similar to distinguish easily.
> When merging these two into a single function, is it acceptable to pass basename((void *)binary_path)
> directly during the uprobe invocation, or should we remove the addition of basename? Thank you!

I think basename is fine, perhaps just pass it as argument
like below (on top of your change, untested)

jirka


---
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9e047641e001..93e804b25da1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11138,14 +11138,13 @@ static const char *tracefs_available_filter_functions_addrs(void)
 			     : TRACEFS"/available_filter_functions_addrs";
 }
 
-static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
-					 const char *kfunc_name, size_t offset)
+static void gen_legacy_event_name(char *buf, size_t buf_sz, const char *name, size_t offset)
 {
 	static int index = 0;
 	int i;
 
 	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
-		 __sync_fetch_and_add(&index, 1), kfunc_name, offset);
+		 __sync_fetch_and_add(&index, 1), name, offset);
 
 	/* sanitize kfunc_name in the probe name */
 	for (i = 0; buf[i]; i++) {
@@ -11274,7 +11273,7 @@ int probe_kern_syscall_wrapper(int token_fd)
 	} else { /* legacy mode */
 		char probe_name[MAX_EVENT_NAME_LEN];
 
-		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
+		gen_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
 		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
 			return 0;
 
@@ -11332,8 +11331,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	} else {
 		char probe_name[MAX_EVENT_NAME_LEN];
 
-		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
-					     func_name, offset);
+		gen_legacy_event_name(probe_name, sizeof(probe_name), func_name, offset);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
@@ -11877,23 +11875,6 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return ret;
 }
 
-static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
-					 const char *binary_path, uint64_t offset)
-{
-	static int index = 0;
-	int i;
-
-	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
-		 __sync_fetch_and_add(&index, 1),
-		 basename((void *)binary_path), (size_t)offset);
-
-	/* sanitize binary_path in the probe name */
-	for (i = 0; buf[i]; i++) {
-		if (!isalnum(buf[i]))
-			buf[i] = '_';
-	}
-}
-
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
@@ -12322,8 +12303,8 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		if (ref_ctr_off)
 			return libbpf_err_ptr(-EINVAL);
 
-		gen_uprobe_legacy_event_name(probe_name, sizeof(probe_name),
-					     binary_path, func_offset);
+		gen_legacy_event_name(probe_name, sizeof(probe_name),
+				      basename((char *) binary_path), func_offset);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)

