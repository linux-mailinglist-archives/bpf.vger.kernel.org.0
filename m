Return-Path: <bpf+bounces-41394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988A996951
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F17B272E7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161441925BB;
	Wed,  9 Oct 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="w2RkE8+s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="okPCcziA"
X-Original-To: bpf@vger.kernel.org
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987B18E343;
	Wed,  9 Oct 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474950; cv=none; b=mtfPw3YnNjtbo6jEb3OdQp+EVZYYRpmf1mTw5wcbs1+VHZyx1Tn+orku55sN0w73fclVPTV0xqHsTAr70pC6P92brucxl+cdIK+lwG9Rdpw2aPwWW3FYO1AQNtjBwivhHY80kDY5UgLbaHvNnQEoG6UetQ/ZwKkW6ZL5xEcrbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474950; c=relaxed/simple;
	bh=s3+cVvgLFHM+DwouZsUL2k7mZ+ERm7xnuVoW9f7FGhQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ki5hUYNj6TyzVDXAG67OBxgADMHakYwL/Yt+Yuvh2tRvGseG1MVXSFHVMqD/WuH8DnC0chxIt4t9ZPILDxjOnPKkRRbd39k9OJmLavlFixndJ0k06tUJWMDbkICb+RztmsUGkqPA8LIhxHN9NuVNv+xMImyxuhtHxms1vYlS2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=w2RkE8+s; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=okPCcziA; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=cXZWoRxwjbXBn18tc3wKflWnKpMi1M5ZYTvVfeqW9KQ=;
	t=1728474947;x=1728564947; 
	b=w2RkE8+s9iGfp0GpbyGcwSdxOk6Csqnfwg4GwvwC/wScXjMkGoEn4shRsk6Sqx/KgIMj3dRh9TbE8CYsdB8H0d1Xt2STZxaD4sbvkYk+iMye0TUx+EsdkB+gK2jQBM/RHRj9tZtPgiepz2t1inC6W07hzVPSqYpOb08pepPWsbHpkhxX5cE2gG1cXafVVwICQqsDYUZAyuT69uiK9reV8P4ALFEN3qfE9Upl8kG2wQwS1r7rIEfKZs4zX/efS5kZfizbCsjzjjpqhn1Owz2EvRTwgcgQzP62dB/CsH7XfTpgybt3kBo6Y7at5VBOEKnnl0EbkG9RpHr+Tna/9g71Iw==;
Received: from [10.12.4.19] (port=54988 helo=smtp43.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <rabbelkin@mail.ru>)
	id 1syUOd-006cNR-8K; Wed, 09 Oct 2024 13:58:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=cXZWoRxwjbXBn18tc3wKflWnKpMi1M5ZYTvVfeqW9KQ=; t=1728471503; x=1728561503; 
	b=okPCcziAFw8pUvcbEF/ecIOAWt7aW0Al5RQVaaUPP6/PJdLP8xKICo2RXopZFOi+IDaVDhJ5U/c
	gwH6xCPuOmoiYmIKKp24raGulAmGvk68tbUhLsQqwOJxMiK0wIKw2/9y98WIxIlKow6EeVe/85P4z
	sr+i+1+3mgQQo0f1AmApQtrjf1eH5wQy7WE0SlNE6fhbVAAbrME0zNhMfwA0u3YOz7945kDbqOFDy
	ZcH+x/NBAUF6k1/uOwuNXmbjilSdjk4pTvgL1v7/q6XcbW11Jzk+mJrEetFDrZN4Gs/ZfW38JYBcb
	FESty7z/aj/a5qQeCuqLTHtmD0vPXGHODZ4Q==;
Received: by exim-smtp-57dbb65494-xkmcn with esmtpa (envelope-from <rabbelkin@mail.ru>)
	id 1syUON-00000000GMS-0s5j; Wed, 09 Oct 2024 13:58:08 +0300
Message-ID: <9679a031-3858-4fef-bb8e-1cf436696095@mail.ru>
Date: Wed, 9 Oct 2024 13:57:58 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Nikita Marushkin <hfggklm@gmail.com>,
 lvc-project@linuxtesting.org
From: Ilya Shchipletsov <rabbelkin@mail.ru>
Subject: [PATCH bpf] bpf: fix %p% runtime check in bpf_bprintf_prepare
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9B01871A0ED523BBF77852951EAFA0AD84A3DDB932672CB59182A05F538085040C832730EF12FC7513DE06ABAFEAF67051659BA8E0298E375A0DED94B4D51F74C080FAAE239EDB74A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72267471453D8B600EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DB576DCB83B448D28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83257F1D3208965B29EAF9340C60C29498DB51EB439D21BBB20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0C26CFBAC0749D213D2E47CDBA5A96583C09775C1D3CA48CFED8273DE7764599A117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7ECE82AE7387CF2AD9FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE72AA49236079A88D2D32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C09F81FD64354FB19DCD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269176DF2183F8FC7C0E9CA1980FA7BB05068655334FD4449CB33AC447995A7AD1842539A7722CA490CD5E8D9A59859A8B627EAE92BBB65E5C0089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5A8371B9EA095D8B85002B1117B3ED69606F944691AC95B8E108A05421C070DB8823CB91A9FED034534781492E4B8EEAD5E90D3DD2A5B7EAFC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8CD220057AD23185746CD51726B9F9AFA0E7D6B159443C156886251CD588C929110A92F5D16EB67FAF66815EE7BDF790E222455611D0F3433A3AECB7D703508A15B4DDF36EB033050D035775BAD7A4FF02C26D483E81D6BE52C818B45C5DF227C6320D7D8A56C4C1F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXiXXbqtSft5C35pPJo7qcJp
X-Mailru-Sender: 9482C2B233321BD26991B35941EDBF335727AAB9AC60205EB951B70A5BD4BD8EFD499732E9EAE5B1FE6B87ED06B33EDA3E4B5285FAD4BB0139D6CA1605B49A4EA3B0E471379AD1B98C20D24C36CDC6F8B6C74420543C50D2F25538641C40D2995C59640A7B0503417C4D6918BD363A91C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B42DA9BE0E4F7CCE4C920C9969AF7F7D50289E8CBDDC4EFD27049FFFDB7839CE9E1B848F739BB0CB65AA62AAED0922B691F639A26577878AA8F12C703618F3CCC1
X-7FA49CB5: 0D63561A33F958A5DB73B3D948A51E0EC487031AE62202473449CE366CC3400BCACD7DF95DA8FC8BD5E8D9A59859A8B64A19EED482128B83CC7F00164DA146DAFE8445B8C89999728AA50765F79006372D0AD69218B09DB0389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80072D29C69FDE18FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7ECE02056093E322D731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojDQmHcgijyZW3lzdabxRdXA==
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

Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
---
 kernel/bpf/helpers.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9e235807cac..bd771d6aacdb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -892,14 +892,19 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 				goto fmt_str;
 			}
 
+			if (fmt[i + 1] == 'K' || fmt[i + 1] == 'x' ||
+			    fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
+				if (tmp_buf)
+					cur_arg = raw_args[num_spec];
+				i++;
+				goto nocopy_fmt;
+			}
+
 			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
-			    ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
-			    fmt[i + 1] == 'x' || fmt[i + 1] == 's' ||
-			    fmt[i + 1] == 'S') {
+			    ispunct(fmt[i + 1])) {
 				/* just kernel pointers */
 				if (tmp_buf)
 					cur_arg = raw_args[num_spec];
-				i++;
 				goto nocopy_fmt;
 			}
 
-- 
2.43.0


