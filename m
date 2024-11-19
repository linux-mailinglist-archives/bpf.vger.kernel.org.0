Return-Path: <bpf+bounces-45165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8F9D2383
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C591F21685
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AEA1C75F2;
	Tue, 19 Nov 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="1EL/oFvi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="FLr8S2+w"
X-Original-To: bpf@vger.kernel.org
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94C1C6F4E;
	Tue, 19 Nov 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011817; cv=none; b=aTRnh3tqPWWj8wjHUwmK5PB1Po24FnpoKTMRVZ4qcGIXrdFUgUOmKNUCsDCiDF4TiAAWwRntg69HIiRW2PJrpUfY7s0SHCPxTVmtkf/Xc6QOTkT4cbHURs5DVapa8sas/bJpVCi2cyCef3X+Wg2C3EOZZ5FBQGJt4DVR7Zy8318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011817; c=relaxed/simple;
	bh=8QbI+KQZ2X6DE1FaQVlLvxSG71ev//HmDnoakv+7LZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmJqTv1uClKD3x4B7yX2twdGn8dHIlfjOHbmdZi/BmPN6mTMFQr+CSicAXvJjwqFgonXa8z1VJzn7vmFoI98RjXggcyUFvf1nVjSIhdHWYSdVcp71C0i8ckDTA/fsufNtSBu8C77+b2oB3HqAauMBRHjliJsQxQTud1PKerqSbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=1EL/oFvi; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=FLr8S2+w; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=uaO4BsfZLe/jvUV+q7i+GZEq5Dp2YNB4/iVgmYkihxI=;
	t=1732011814;x=1732101814; 
	b=1EL/oFviFJCstaPRG9OrfbcGgE2oAamiwbfu5fc0T7n0W8sYt0e6KDiSBzeIViYu62Z5eUp05D/PxyWk1CRzAVoGXJhZ/dvQ6eTK5ie1BtOxvoBSj3StuEcJj+pAP0yDzor/WxYQ6Nn2NZXtqu2rTMpD/g6UleLNhtXAE2qciCYOsfoHf8XjATE4KeZKBXRmpzH1Y8YWU9f0TZ1Efy4v7xCvF0M1IMOTACYMpBMRaCaZjutkcQO11GvYozwDDKsN89cmpequcnFZOuQGz6cNpvecrTXyxMk88CbMrVkJ5z09cStrZROMqSem8pL7meE130Ctdbwgc0a+IDhOEXsnyw==;
Received: from [10.113.222.165] (port=54270 helo=smtp29.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <rabbelkin@mail.ru>)
	id 1tDLOI-00EqqB-4E; Tue, 19 Nov 2024 13:23:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=uaO4BsfZLe/jvUV+q7i+GZEq5Dp2YNB4/iVgmYkihxI=; t=1732011806; x=1732101806; 
	b=FLr8S2+wkri+JwUyTylqg/EG5HI0NF0OiWBjdp7h8OAxJrkcGgKITQtmS7LFPGjecSd9IAnodTF
	VMUQe+/Z1wab6qtJBOnCWRi0z0TbCJMfHOGjbUIadTrIfg+5+OaFsOpW3KnbPT5sJmEGJx43upU4/
	FT35+885veHLXaT/vRE6syYZcKvHWroQL3GogkSMWkZlHcsq82SzUTECohq24Esq95T6T9/YvATMO
	8URmV+EouUnD4IZuYu2PDJgcMHjuBLMCPcVV+0fPbfM13fX9APMVGPtOnOvQqZjfbggyvbN4WyS10
	T5uQJxc732bmgMSE9gW5U6fD0oiuYAEF1MJQ==;
Received: by exim-smtp-68dd957ff6-p9gt6 with esmtpa (envelope-from <rabbelkin@mail.ru>)
	id 1tDLO3-00000000CiI-1bnu; Tue, 19 Nov 2024 13:23:11 +0300
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
Subject: [PATCH bpf v3 1/2] bpf: fix %p% runtime check in bpf_bprintf_prepare
Date: Tue, 19 Nov 2024 10:22:12 +0000
Message-ID: <20241119102214.2145-2-rabbelkin@mail.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119102214.2145-1-rabbelkin@mail.ru>
References: <20241119102214.2145-1-rabbelkin@mail.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD95367647A2C12583F2C8F5ECE26118F812B5164FFEEF29B9C182A05F538085040D8946AA7A5050A073DE06ABAFEAF6705CE5A38E7B1AEB6BEFC233B5B959DB54A285C021E7E0FF4E2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AC5438007118D6FAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DC5B68A43B0CFEA28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8BB0A5C9EAD79B1B2902AD53BEE3A1E7DC734D7D720DFAC9320879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0A3E989B1926288338941B15DA834481FA18204E546F3947CBC0ADEB1C81BB362F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637036D0B7DAED17EFF389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006370DB91CA68F887047D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7BFFE0AA609035320EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C336AEC206CEF325C735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A51CB76FDC63C159A15002B1117B3ED696A6BD7BD901F79D1CC81EEE05487B0209823CB91A9FED034534781492E4B8EEADED8273DE7764599AC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF35C5DC6B9DF3B56886A9E6B353485A8AD9DB0F30512F5FED7F64C53ED96E807A80A302719471681B0C86AA3C630759CE13484C39A164D2B8803A5E51012C5D8CA1315DEC946E28F7F59F2EA2782EDE9C02C26D483E81D6BE52C818B45C5DF227C6320D7D8A56C4C1F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpjtgd3uP0q0bqGKCNZ5mAA==
X-Mailru-Sender: 520A125C2F17F0B129A91D4D2C73336DE37505FA7708B55D3DE06ABAFEAF6705CE5A38E7B1AEB6BE87BBD21BC54961EB7D4011A27D7B18D45A92E71CC7C3152D768DA86FCF4447625FD6419AF7853D25851DE5097B8401C6C89D8AF824B716EB3E16B1F6FB27E47C394C4C78ECC52E263DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4627F043E32F6F38D6858A64E51D93CC603595D0356BF530EB647ED114AB003AC4F6C5ED74B3D22F6463A7FC376387111E5BFDDA618AB12895A7663029CF1AC4F
X-7FA49CB5: 0D63561A33F958A51698696E8C576AC6B8577862450CB26024F817A8679254B0CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637BDFDCB0E901A2C23389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8B26E97DCB74E6252F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE77D11AC4126952D87731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpjtgd3uP0q0orqcrT1iRfQ==
X-Mailru-MI: 8000000000000800
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Florent Revest <revest@chromium.org>
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


