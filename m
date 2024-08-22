Return-Path: <bpf+bounces-37823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7582795AD30
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF7F1F23464
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 06:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930141339A4;
	Thu, 22 Aug 2024 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BumF4hjQ"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5621D12E6;
	Thu, 22 Aug 2024 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306960; cv=none; b=LDBFt6OW1YXB/2lFBh7VIq9enEB12++/gN7fk/2TTttzf3xiVoa2BxEr1VtM8GaNcanAwOfIdxKXPmP4O2xGXk6fgQOup8qZJ2titoMT7zdBPjW/5Y+KKzWo0J/rjCzYVCNYwI9YbNkKOsKfm1O7VARbzbIe3X64Wnga8znWw+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306960; c=relaxed/simple;
	bh=NGpXsx7dgwIfGJMb97R57CZgwLbo52OS/ujeqqpq5Oc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ae6K2fRvHnLOKixIZdsAPgROpLsGLOq5Tw9iYkweC/uhInsnLLW9FRSxylIqFMQ+N49vL5V5d2EgDSbY8hbOSXuDjHvcVp0H92vW/3dAQfOpofCVraZx6cj5qJzVcvDnmE/BTprJDwOEM4rA7znp6BXDUKZxVE5aQoHY90KwKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BumF4hjQ; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724306944;
	bh=orGZxRP3EmbphZg4hF8C2M+U0CoOGrb/LiKV+L4HuA0=;
	h=From:To:Cc:Subject:Date;
	b=BumF4hjQwBDaHIp8525WDihtg0USlYtDJE5BVpVNg8TjBVaFRldgM3a007boj8YGD
	 XoS+k+Run1DUjXurIo42kre5HItkH5jjBVDDurXbb/dtW4UadKoJUURi/m1zKWFTap
	 +Ks1dTx8TfLDAfgKMQX8lnwHkaebErLa90qGB2NY=
Received: from yangang-TM1701.. ([39.156.73.13])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 241A9408; Thu, 22 Aug 2024 14:09:01 +0800
X-QQ-mid: xmsmtpt1724306941t8je71d09
Message-ID: <tencent_1E619C9E44C8C4B2B713A0D6DD45B92BF70A@qq.com>
X-QQ-XMAILINFO: MIbv1O9N9h62Qr1HLJ3ccuVvVypmbn5wxo0/QMMFMv6sKV5lCwu4150jngyn3V
	 ycbSrMM62aB4Utmu5eonUju4jJQc+KefLTocCDbkyO0MVfNp7eO8gQ1i7TRNst6UJ+QzTXvJaljd
	 /2/UcmXvFiTf0OXiDgZqCeu40hq8D0PBR5589ZKqi/H+FMMsqouS8yVATF7T3jHWaD5kh9ByOKQg
	 BIgQIN3N05G/BgFyD7TZ0YfaOW05TsRfIYB95QvvWKPUsFRRIj4hfKo6HAUdndUCp3eJ4fQZeWft
	 BtUiMswufZMaFmOhOJX++6jzddGNDA7+Zwz440i4jWd3UEYTmF7+VitmUwgMUMg/ctkeFOMYgr9E
	 Fwri4r3ULgxnC5wfRpfbVMqK3PmtAvLjMaWqoP3XryMh2f6EHGAbQMiveGXm1py+znuACgMTY9YA
	 pf5DDVTCF+qIgP3W2f5TY+z/AT4YvirTVY7vi19cgzlD1QxW2RD+lCZ+Z37rxECDLNscE4KLrowC
	 pAJSuld0dIslN/mVXEvnAfrJt8aSIMkNSjRsTm5Af761ib6MYYavy1OKOgoirWn3G038boo9x5IO
	 4006HC/q3wh0bv+Y7/7RME6gQAn4KDLvK0njmFDbUszSAMXigDVY0ifJOGV6SHchegHyrx3HSqlu
	 zav2PxI5bWgiu4nwVI32PAYNke41w2ySnPrLUhSTkX6czqcPiKGUCnaTMyQZN+OR8punkBCj1VTa
	 d8vCS0jXw8Oqw41Ip7ea0l87t2WPCh7jXwUX3SRRPQN1KKxvWmy6Lf6dbq9AnbuaaSzLBczVPgie
	 uM2DTlvwEhyMeBlEhawKhXHqpr1X2hO2ysAa0nJrJE9DcHXCrYG7uCdme/STqKeeWGnIQFq4MVmE
	 c1zDsMH7EafT4Xwwghj9lwMiyJV4FVO3YB9GHNLcib4uTTlWQxd2annDAqYk6QH+8QT20wCb4p9g
	 /Ti6a4ZJaXekGM8iL0O6H9oJIQIwoITiwLkWw1zPhQlv3mprvOq6u9GEsNurv2aG9wYvny8IN8Cx
	 HsBKMG/n8najCv/W9U2O3T28XslPM=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Gang Yan <gang_yan@foxmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gang Yan <yangang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next] bpf: Allow error injection for update_socket_protocol
Date: Thu, 22 Aug 2024 14:08:57 +0800
X-OQ-MSGID: <20240822060859.944379-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

The "update_socket_protocol" interface is designed to empower user space
with the capability to customize and modify socket protocols leveraging
BPF methods. Currently, it has only granted the fmod_ret permission,
allowing for modifications to return values. We are extending the
permissions further by 'ALLOW_ERROR_INJECTION', thereby facilitating
the development of user-space programs with enhanced flexibility and
convenience.

When we attempt to modify the return value of "update_socket_protocol"
to "IPPROTO_MPTCP" using the below code based on the BCC tool:

'''
int kprobe__update_socket_protocol(void* ctx)
{
    ...
    bpf_override_return(ctx, IPPROTO_MPTCP);
    ...
}
'''

But an error occurs:

'''
ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
Traceback (most recent call last):
  File "/media/yangang/work/Code/BCC/test.py", line 27, in <module>
    b = BPF(text=prog)
        ^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 487, \
                  in __init__ self._trace_autoload()
  File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 1466, \
                  in _trace_autoload self.attach_kprobe(
  File "/usr/lib/python3/dist-packages/bcc/__init__.py", line 855,\
                  in attach_kprobe
    raise Exception("Failed to attach BPF program %s to kprobe %s"
Exception: Failed to attach BPF program b'kprobe__update_socket_protocol' \
  to kprobe b'update_socket_protocol', it's not traceable \
  (either non-existing, inlined, or marked as "notrace")
'''

This patch can fix the issue.

Suggested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..63ce1caf75eb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1695,6 +1695,7 @@ __weak noinline int update_socket_protocol(int family, int type, int protocol)
 {
 	return protocol;
 }
+ALLOW_ERROR_INJECTION(update_socket_protocol, ERRNO);
 
 __bpf_hook_end();
 
-- 
2.43.0


