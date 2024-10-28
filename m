Return-Path: <bpf+bounces-43336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687429B3BA6
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 21:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271A92827CA
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CDD1E0B89;
	Mon, 28 Oct 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="DaPk++n/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="LxTvrICn"
X-Original-To: bpf@vger.kernel.org
Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F91E0B6E;
	Mon, 28 Oct 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147146; cv=none; b=CMiMF+m/CbZ3ARW3hLtXcE12G9vKrxCA+ll5i3oRtVLFMa4olHS6RDkWSCRNA20SvbajHp1TMBtQk8DLq0ldKAqniOyDRpkfKkiegDGaexEDhmDkWMwPJFPRAkoQw8Bx0P4Kao5+XSPQef1xXgCz8WgD6G9LsS0hksOQnhAzKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147146; c=relaxed/simple;
	bh=bAWtMIED/ONZrKaO4ebZq1uVxno/+5eWZQwBlc2mVgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOrnfnW1MDDDiIZcaayD6eTjGIh3En6aCTg4H6Y5fZkZPe5nMRQq1Fu6Ucg0b4H5QbJGjUcDrkLzNBC4W1Lv7zsvbIqUgmIW9GLTQ95wQEmT7TAXR7bRBYzZVrUqSd6fUbctOSORE062k4iB2aDBumiUC/RlyDUO1hF02NxMF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=DaPk++n/; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=LxTvrICn; arc=none smtp.client-ip=79.137.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=B3AL27AflTqoYujgqQL3TECsmEVTanLlOXOcHUOU554=;
	t=1730147142;x=1730237142; 
	b=DaPk++n/4bbotaCR6kI5BGW5R/7lrJxT/5+kHQ8zFtA5xeqR+B+E5kxBUgSQR67ICiRhzD58wNtxrhT91tyN96eABvlhweyBiOWS0TgAlwmZ/kAyXBO6R3zN96XYgNwsWq+8vhX87yTp7S30ELjNkbBW4NyMYead89+EasZwHAgYTI6xPyWVJrS5SoICUUSm4saA9siwi8OFJ0lF251trbTE1iAb9Fua3U05372hK4Xt89iKc+XE7UwJgjBrqAJlDUxtbeqXZEd/LQl6B4jOz9kBT4EKzCEKeMrGrLcvYCyDFa0Qa+xSs+fp5UZYX7ljAuo49jjarEuuJuzCdhL63g==;
Received: from [10.113.187.255] (port=37322 helo=smtp30.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <rabbelkin@mail.ru>)
	id 1t5Vob-004Zlt-AT; Mon, 28 Oct 2024 22:54:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=B3AL27AflTqoYujgqQL3TECsmEVTanLlOXOcHUOU554=; t=1730145253; x=1730235253; 
	b=LxTvrICnqC9xfp1QI8//unKqHY1xKa21IDuzUp1+9CXO6QAqftilS44ovHDJbkK6bJmtBSz+C5F
	wJgcQ74nM7vqTwDbyo26jauiYpL5GhVezlcn2uApdXuykGuqJqBRKZCX9PQfxFfcZCXDueLEDcCMw
	qWn9x6OegpalxbxXZ2HOzrHokOnsw/tgQCjweXnbVFQ6uH0k1jXGybTaCUuQVgWAhSmHZqICqYXAI
	Xk2XHpkmOMpRPECBjKq0N4CznS8+DM5bp6F4oH43w8qKqGKSKh+u/wyJhP25mxzijvO1f2lJ4lx3D
	wXhFYEGlschq5oQi2qsLEff3jLWtPDvD/sDw==;
Received: by exim-smtp-7fbf7c596c-sbqxq with esmtpa (envelope-from <rabbelkin@mail.ru>)
	id 1t5VoN-000000006rV-0bfz; Mon, 28 Oct 2024 22:53:59 +0300
From: Ilya Shchipletsov <rabbelkin@mail.ru>
To: bpf@vger.kernel.org
Cc: Ilya Shchipletsov <rabbelkin@mail.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Florent Revest <revest@chromium.org>,
	Nikita Marushkin <hfggklm@gmail.com>,
	lvc-project@linuxtesting.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: fix %p% runtime check in bpf_bprintf_prepare
Date: Mon, 28 Oct 2024 19:53:40 +0000
Message-ID: <20241028195343.2104-2-rabbelkin@mail.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028195343.2104-1-rabbelkin@mail.ru>
References: <20241028195343.2104-1-rabbelkin@mail.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD93D9A9D6B172791922FEED64A71C7ED8DB0414F963B22963C00894C459B0CD1B9461BC5E8F95134772EB5D77EF37489D1F64FF9D56DB9B8CA1905FAAC1F16330F42B98C014DDF718D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE731B6267C8418DDA1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063727C65896DA7AF7D78638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86C4E64A18E5A8DCEE21390611866FCBA8E46AF69C7E20B6D20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0AF05157F0BAFB9978941B15DA834481FA18204E546F3947C2D01283D1ACF37BAF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063781612DB815465C93389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637C3D27F5126D5EA7BD81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE74EA008C085C70549EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6957A4DEDD2346B4275ECD9A6C639B01B78DA827A17800CE79178F0054B4A1A06731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5F6F8224AC86606015002B1117B3ED69635370DFBF8F2C00FF5FEB6EB1EB183FD823CB91A9FED034534781492E4B8EEADE0C144949FACE77EC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF53BF90922B0431419F2B4923BACA6E26E91430E34D3558F1CC6E03D0B065EEE7F6452569441AF36462F6083D2AD86BCEA8FA540365190C7AB13A1D2A028F3448C583770CEA4E9914F59F2EA2782EDE9C02C26D483E81D6BE52C818B45C5DF227C6320D7D8A56C4C1F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxgmIyQdMaRqSLy6EB70DoQ==
X-Mailru-Sender: 520A125C2F17F0B129A91D4D2C73336DA0DC2FE96B1554DC3DE06ABAFEAF6705BF41A9187C8E24E887BBD21BC54961EB7D4011A27D7B18D45A92E71CC7C3152D768DA86FCF4447625FD6419AF7853D25851DE5097B8401C6C89D8AF824B716EB3E16B1F6FB27E47C394C4C78ECC52E263DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4EB5CF5EDE64A1802999F17DC78C05B002911CD8180D91453049FFFDB7839CE9E1556864DF1AA0A9106ABF908EFDED9A8FB1C45E335AA0185C192C7311A032116
X-7FA49CB5: 0D63561A33F958A5F95F8A4A4AEC4598A2E26FE8E17E00CE6C55481626F52EE0CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006377A889D471060CB06389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8783D6DB41994EC49F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7897BF32459B96943731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxgmIyQdMaRr1bfRMQ+wWxw==
X-Mailru-MI: 8002000000000800
X-Mras: Ok

Fuzzing reports a warning in format_decode()

Please remove unsupported %� in format string
WARNING: CPU: 0 PID: 5091 at lib/vsprintf.c:2680 format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
Modules linked in:
CPU: 0 PID: 5091 Comm: syz-executor879 Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
Call Trace:
 <TASK>
 bstr_printf+0x137/0x1210 lib/vsprintf.c:3253
 ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
 bpf_trace_printk+0x1a1/0x230 kernel/trace/bpf_trace.c:375
 bpf_prog_21da1b68f62e1237+0x36/0x41
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_test_run+0x40b/0x910 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1066
 bpf_prog_test_run+0x33c/0x3b0 kernel/bpf/syscall.c:4291
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The problem occurs when trying to pass %p% at the end of format string,
which would result in skipping last % and passing invalid format string
down to format_decode() that would cause warning because of invalid
character after %.

Fix issue by advancing pointer only if next char is format modifier.
If next char is null/space/punct, then just accept formatting as is,
without advancing the pointer.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
---
 kernel/bpf/helpers.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..3efa8b04999a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -889,10 +889,8 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 				goto fmt_str;
 			}
 
-			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
-			    ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
-			    fmt[i + 1] == 'x' || fmt[i + 1] == 's' ||
-			    fmt[i + 1] == 'S') {
+			if (fmt[i + 1] == 'K' || fmt[i + 1] == 'x' ||
+			    fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
 				/* just kernel pointers */
 				if (tmp_buf)
 					cur_arg = raw_args[num_spec];
@@ -900,6 +898,13 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 				goto nocopy_fmt;
 			}
 
+			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
+			    ispunct(fmt[i + 1])) {
+				if (tmp_buf)
+					cur_arg = raw_args[num_spec];
+				goto nocopy_fmt;
+			}
+
 			if (fmt[i + 1] == 'B') {
 				if (tmp_buf)  {
 					err = snprintf(tmp_buf,
-- 
2.43.0


