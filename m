Return-Path: <bpf+bounces-51817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B53A39633
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 09:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F95E18934AE
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F8222F152;
	Tue, 18 Feb 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oy8paixi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF522E002
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868861; cv=none; b=Hvwb7Em6agnnAMVXruGV+Yt8VfJtzwuQel7sOEwP3KAyyWflLJ5uXXDoBTYkZS3UUyYTMK4S9N+RnTkNLiN5Jc5marDK0nOkZgdOdrqiZ+2G4aqxXWKUDKEDg+MvF/PoOSukzWwPyobwANG01i4qSMFNbRl2m3LjC0quDvTU73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868861; c=relaxed/simple;
	bh=jwI/lNP5dSvyttLJubFZYl0XG36disqSc5jQ94EQu84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr5scNWNqs+j4+Q1dw0S+vskeg30DV/iEYYbCmuPiiCoQvin6dsxKHO3KNKZYeCZVoDfo11EZk/4iiYupocP6IJ8ALd50I5jz8gjbW8OR88ifq6DpJL6KKJ8Waa3xRYuhAGxjwxPNGNyQrfO3IDgLjDniwWN2a9jt7K2pNBjOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oy8paixi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ag0dHU2PJNcElfhJQr4ZktwRcHGH3gFXUMCanAlAuaQ=;
	b=Oy8paixixrZvTriK4BbsIYlNIh8irNXhX7UIlKw9PELwfIScJxDn6nZNgT+rPBbutYbXvA
	UvmA6bP4XzrR1jFGiuGH3A6VlhFXLwS+crPG2Rho1sMogF8EzpGEml5P6XRGL75WIel3uh
	qrhu0A7mKcQ4T+C9hEDTQuvEfkV7A9Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-q3feVInqP7-FjBF5WRVdBg-1; Tue, 18 Feb 2025 03:54:15 -0500
X-MC-Unique: q3feVInqP7-FjBF5WRVdBg-1
X-Mimecast-MFC-AGG-ID: q3feVInqP7-FjBF5WRVdBg_1739868854
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-439385b08d1so46157945e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 00:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868854; x=1740473654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag0dHU2PJNcElfhJQr4ZktwRcHGH3gFXUMCanAlAuaQ=;
        b=kB1W5rrVFkf9BE3XrmG7dPmxQCXyzovuUIyN7jJpeCiMGB6+B00IHsOD7guz7W6QNV
         EFs4wokjacKRZd1KB30g7AJMXkdQloXc/WldLBFYR5yafWbBGjAI3VwO3U6F3uF9T4vP
         OBXwYnnG0T2oujrW1Fyh6uDUBRE7bXtHVd6rTVfYPHkFkLlA0X86R4iOMnmLSM9SYDRh
         kKWoXNLfLfR9H36yPsrrDPhviN6qMsKwXCqz6BaTcb0FliZVEyycGuYvP8Mwd+hMYymV
         JVuuzRIMv/jfTiYZpGYgReT4V8SZU21DuVSpBruxdnSjTMMkOkO+GMKOxx//J+iXQUOs
         ixFw==
X-Forwarded-Encrypted: i=1; AJvYcCW7FIDWmIiZSvsoiSvOCsjEEFflJgZxokXxhCA7GsNjM6FHTsFWcpTLjG/hOG2Sz22XgQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSBvwfrrO29Jq/+1NzCGm0WfAqVAjSlA070B9U1McRAglgwym
	ZmtyPysiIGM2M2qs1ae2aP/YDNMz0muS7g/V0CfpVG4WtJwHmDlJPG8WV2XbWfkL+6tImtSoZt+
	aVWh6HCR2lyXkg/IAw0cMLW3F1fRWooFDsLb8BwQmmsfFjkxzEg==
X-Gm-Gg: ASbGncsakzk5QHDURg1LhXOKFNYgdBvjl2EGkyq+RytihXpty1URHJHSt82A7fn/Wcc
	AkvxffnE0iKcIfvsJrnBmXiXA21hytPNWebKv4U/Nl/9NzxV+xTRgRDbbcbsUe++NDbTFa1Hmsg
	/5+E4Qy7hlR/upDv/VMqYcQJ+2hYlZWE4gqTrCi6MTsTQhJhPRZgLDlYEMUSlrem7EEyUEEv2Mu
	eK4lRZVgNSQzZTMC0GYdcZOPkn9pKVi9ByxK2Nq1a+qdtQ+LP4QddOBsSi7VU6eXR885+C8DVuf
	T7EhPNDL3UidmVuNosQcRU02aUmYQ19KbH8CyzigQh0SsVzdAHr8vw==
X-Received: by 2002:a05:600c:3848:b0:439:63de:3611 with SMTP id 5b1f17b1804b1-4396e70c72emr96432095e9.24.1739868853701;
        Tue, 18 Feb 2025 00:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrzQUcLDdRMbQ9tpTOvarMcJ+9b/19xmbIKWDGHi26EJ7bkp2+quEuTCCvx3hfiQoyjF9vvQ==
X-Received: by 2002:a05:600c:3848:b0:439:63de:3611 with SMTP id 5b1f17b1804b1-4396e70c72emr96431525e9.24.1739868853107;
        Tue, 18 Feb 2025 00:54:13 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm43986245e9.31.2025.02.18.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:54:12 -0800 (PST)
Date: Tue, 18 Feb 2025 09:54:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 4/4] selftest/bpf: Add vsock test for sockmap
 rejecting unconnected
Message-ID: <6p7yfobgfnms4m77k7whp4k3ft7m2vhmroacsd3stxmbxzzrwk@pmtz656ldbxc>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-4-994b7cd2f16b@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-4-994b7cd2f16b@rbox.co>

On Thu, Feb 13, 2025 at 12:58:52PM +0100, Michal Luczaj wrote:
>Verify that for a connectible AF_VSOCK socket, merely having a transport
>assigned is insufficient; socket must be connected for the sockmap to
>accept.
>
>This does not test datagram vsocks. Even though it hardly matters. VMCI is
>the only transport that features VSOCK_TRANSPORT_F_DGRAM, but it has an
>unimplemented vsock_transport::readskb() callback, making it unsupported by
>BPF/sockmap.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> .../selftests/bpf/prog_tests/sockmap_basic.c       | 30 ++++++++++++++++++++++
> 1 file changed, 30 insertions(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>index 21793d8c79e12b6e607f59ecebb26448c310044b..05eb37935c3e290ee52b8d8c7c3e3a8db026cba2 100644
>--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>@@ -1065,6 +1065,34 @@ static void test_sockmap_skb_verdict_vsock_poll(void)
> 	test_sockmap_pass_prog__destroy(skel);
> }
>
>+static void test_sockmap_vsock_unconnected(void)
>+{
>+	struct sockaddr_storage addr;
>+	int map, s, zero = 0;
>+	socklen_t alen;
>+
>+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
>+			     sizeof(int), 1, NULL);
>+	if (!ASSERT_OK_FD(map, "bpf_map_create"))
>+		return;
>+
>+	s = xsocket(AF_VSOCK, SOCK_STREAM, 0);
>+	if (s < 0)
>+		goto close_map;
>+
>+	/* Fail connect(), but trigger transport assignment. */
>+	init_addr_loopback(AF_VSOCK, &addr, &alen);
>+	if (!ASSERT_ERR(connect(s, sockaddr(&addr), alen), "connect"))
>+		goto close_sock;
>+
>+	ASSERT_ERR(bpf_map_update_elem(map, &zero, &s, BPF_ANY), "map_update");
>+
>+close_sock:
>+	xclose(s);
>+close_map:
>+	xclose(map);
>+}
>+
> void test_sockmap_basic(void)
> {
> 	if (test__start_subtest("sockmap create_update_free"))
>@@ -1131,4 +1159,6 @@ void test_sockmap_basic(void)
> 		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKHASH);
> 	if (test__start_subtest("sockmap skb_verdict vsock poll"))
> 		test_sockmap_skb_verdict_vsock_poll();
>+	if (test__start_subtest("sockmap vsock unconnected"))
>+		test_sockmap_vsock_unconnected();
> }
>
>-- 
>2.48.1
>


