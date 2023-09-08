Return-Path: <bpf+bounces-9486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B29B798707
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254051C20CDC
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9A538A;
	Fri,  8 Sep 2023 12:31:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2872F53B1
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 12:31:08 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED91BF4
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 05:31:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9f2827131so128284366b.1
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1694176261; x=1694781061; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=i8MKrJNm8Y9rpAzWjXq+MxTzvYBLtE7VqGoTUkyI/+w=;
        b=Hjaz00jmGceZYBCryJ0GOxUGhxW4j/MJaYz2bnfsLrcbSm5GZgpTkQsoyX+cdgRTpE
         /xE/2zgp9vp7iNNZj3AoJc2uMfUC9vEvCzzyh6ShDvdImsIB8wL4OTX/QCZh7qBOzfoz
         fbktw5S0vRFfzKF/Ig9Zw3iCdLjf3YQWh1cGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176261; x=1694781061;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8MKrJNm8Y9rpAzWjXq+MxTzvYBLtE7VqGoTUkyI/+w=;
        b=KsLRVdrMtSqauYjb0Ktj5DC7v4ephPBbhCSo3unpnyM1ki/Exaf+MVxWE+ca2DWhP9
         6l4QRpk69k+SGltBRVoWAKpqkz6whaByENvJgaqWDqQKIycw8WveQmH5PWPH9yJUGTx8
         hVZOZm9c0OZ07ucYPygTZ+dBzIS6jCG8paY8KKqP5Fc4J5mNLjsKmBEyMWbMnO2R34AQ
         7y8JXxqpGblyum1gNUn8JnJ+oWh8rWJzwAQQuETG7mRAETu8gYW2P0YLl/obeKp0pdZX
         jd6v+Iz5sRXpf0fzU7eLuSBdwePzxGQ8jsrGoLG/5RWNDjIC0aUsmK4f68W5VByrDMga
         BQxw==
X-Gm-Message-State: AOJu0YyuTuX/P7eqhnR2SjHlfk1qArKma2zRETwNgMqUkxlwHmRrTli6
	miZTKdFSJyu14LdVNiGu3HCV2A==
X-Google-Smtp-Source: AGHT+IFPF1vi86ZEJSjDKf7baOwConcsjR4XzDItksy5mjCO/rHqSnTTGRqwGh8SwUzymzVBhCJuUg==
X-Received: by 2002:a17:907:77c3:b0:9a1:f2d3:ade9 with SMTP id kz3-20020a17090777c300b009a1f2d3ade9mr1665830ejc.42.1694176261376;
        Fri, 08 Sep 2023 05:31:01 -0700 (PDT)
Received: from cloudflare.com (79.184.211.77.ipv4.supernova.orange.pl. [79.184.211.77])
        by smtp.gmail.com with ESMTPSA id os10-20020a170906af6a00b0099b921de301sm973415ejb.159.2023.09.08.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 05:31:00 -0700 (PDT)
References: <20230902100744.2687785-1-liujian56@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/7] add BPF_F_PERMANENT flag for sockmap
 skmsg redirect
Date: Fri, 08 Sep 2023 14:29:11 +0200
In-reply-to: <20230902100744.2687785-1-liujian56@huawei.com>
Message-ID: <87o7ickfss.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 02, 2023 at 06:07 PM +08, Liu Jian wrote:
> v3->v4: Change the two helpers's description.
> 	Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.

Sorry, will need some more time to review this.

I wanted to test it and noticed we have a regression in sockamp in
bpf-next @ 831c4b3f39c7:

# ./test_progs -t sockmap_listen
[   17.941468] bpf_testmod: loading out-of-tree module taints kernel.
[   17.941888] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
#213/1   sockmap_listen/sockmap IPv4 TCP test_insert_invalid:OK
#213/2   sockmap_listen/sockmap IPv4 TCP test_insert_opened:OK
#213/3   sockmap_listen/sockmap IPv4 TCP test_insert_bound:OK
#213/4   sockmap_listen/sockmap IPv4 TCP test_insert:OK
#213/5   sockmap_listen/sockmap IPv4 TCP test_delete_after_insert:OK
#213/6   sockmap_listen/sockmap IPv4 TCP test_delete_after_close:OK
#213/7   sockmap_listen/sockmap IPv4 TCP test_lookup_after_insert:OK
#213/8   sockmap_listen/sockmap IPv4 TCP test_lookup_after_delete:OK
#213/9   sockmap_listen/sockmap IPv4 TCP test_lookup_32_bit_value:OK
#213/10  sockmap_listen/sockmap IPv4 TCP test_update_existing:OK
#213/11  sockmap_listen/sockmap IPv4 TCP test_destroy_orphan_child:OK
#213/12  sockmap_listen/sockmap IPv4 TCP test_syn_recv_insert_delete:OK
#213/13  sockmap_listen/sockmap IPv4 TCP test_race_insert_listen:OK
#213/14  sockmap_listen/sockmap IPv4 TCP test_clone_after_delete:OK
#213/15  sockmap_listen/sockmap IPv4 TCP test_accept_after_delete:OK
#213/16  sockmap_listen/sockmap IPv4 TCP test_accept_before_delete:OK
#213/17  sockmap_listen/sockmap IPv4 UDP test_insert_invalid:OK
#213/18  sockmap_listen/sockmap IPv4 UDP test_insert_opened:OK
#213/19  sockmap_listen/sockmap IPv4 UDP test_insert:OK
#213/20  sockmap_listen/sockmap IPv4 UDP test_delete_after_insert:OK
#213/21  sockmap_listen/sockmap IPv4 UDP test_delete_after_close:OK
#213/22  sockmap_listen/sockmap IPv4 UDP test_lookup_after_insert:OK
#213/23  sockmap_listen/sockmap IPv4 UDP test_lookup_after_delete:OK
#213/24  sockmap_listen/sockmap IPv4 UDP test_lookup_32_bit_value:OK
#213/25  sockmap_listen/sockmap IPv4 UDP test_update_existing:OK
#213/26  sockmap_listen/sockmap IPv4 test_skb_redir_to_connected:OK
#213/27  sockmap_listen/sockmap IPv4 test_skb_redir_to_listening:OK
#213/28  sockmap_listen/sockmap IPv4 test_skb_redir_partial:OK
#213/29  sockmap_listen/sockmap IPv4 test_msg_redir_to_connected:OK
#213/30  sockmap_listen/sockmap IPv4 test_msg_redir_to_listening:OK
#213/31  sockmap_listen/sockmap IPv4 TCP test_reuseport_select_listening:OK
#213/32  sockmap_listen/sockmap IPv4 TCP test_reuseport_select_connected:OK
#213/33  sockmap_listen/sockmap IPv4 TCP test_reuseport_mixed_groups:OK
#213/34  sockmap_listen/sockmap IPv4 UDP test_reuseport_select_listening:OK
#213/35  sockmap_listen/sockmap IPv4 UDP test_reuseport_select_connected:OK
#213/36  sockmap_listen/sockmap IPv4 UDP test_reuseport_mixed_groups:OK
#213/37  sockmap_listen/sockmap IPv4 test_udp_redir:OK
#213/38  sockmap_listen/sockmap IPv4 test_udp_unix_redir:OK
#213/39  sockmap_listen/sockmap IPv6 TCP test_insert_invalid:OK
#213/40  sockmap_listen/sockmap IPv6 TCP test_insert_opened:OK
#213/41  sockmap_listen/sockmap IPv6 TCP test_insert_bound:OK
#213/42  sockmap_listen/sockmap IPv6 TCP test_insert:OK
#213/43  sockmap_listen/sockmap IPv6 TCP test_delete_after_insert:OK
#213/44  sockmap_listen/sockmap IPv6 TCP test_delete_after_close:OK
#213/45  sockmap_listen/sockmap IPv6 TCP test_lookup_after_insert:OK
#213/46  sockmap_listen/sockmap IPv6 TCP test_lookup_after_delete:OK
#213/47  sockmap_listen/sockmap IPv6 TCP test_lookup_32_bit_value:OK
#213/48  sockmap_listen/sockmap IPv6 TCP test_update_existing:OK
#213/49  sockmap_listen/sockmap IPv6 TCP test_destroy_orphan_child:OK
#213/50  sockmap_listen/sockmap IPv6 TCP test_syn_recv_insert_delete:OK
#213/51  sockmap_listen/sockmap IPv6 TCP test_race_insert_listen:OK
#213/52  sockmap_listen/sockmap IPv6 TCP test_clone_after_delete:OK
#213/53  sockmap_listen/sockmap IPv6 TCP test_accept_after_delete:OK
#213/54  sockmap_listen/sockmap IPv6 TCP test_accept_before_delete:OK
#213/55  sockmap_listen/sockmap IPv6 UDP test_insert_invalid:OK
#213/56  sockmap_listen/sockmap IPv6 UDP test_insert_opened:OK
#213/57  sockmap_listen/sockmap IPv6 UDP test_insert:OK
#213/58  sockmap_listen/sockmap IPv6 UDP test_delete_after_insert:OK
#213/59  sockmap_listen/sockmap IPv6 UDP test_delete_after_close:OK
#213/60  sockmap_listen/sockmap IPv6 UDP test_lookup_after_insert:OK
#213/61  sockmap_listen/sockmap IPv6 UDP test_lookup_after_delete:OK
#213/62  sockmap_listen/sockmap IPv6 UDP test_lookup_32_bit_value:OK
#213/63  sockmap_listen/sockmap IPv6 UDP test_update_existing:OK
#213/64  sockmap_listen/sockmap IPv6 test_skb_redir_to_connected:OK
#213/65  sockmap_listen/sockmap IPv6 test_skb_redir_to_listening:OK
#213/66  sockmap_listen/sockmap IPv6 test_skb_redir_partial:OK
#213/67  sockmap_listen/sockmap IPv6 test_msg_redir_to_connected:OK
#213/68  sockmap_listen/sockmap IPv6 test_msg_redir_to_listening:OK
#213/69  sockmap_listen/sockmap IPv6 TCP test_reuseport_select_listening:OK
#213/70  sockmap_listen/sockmap IPv6 TCP test_reuseport_select_connected:OK
#213/71  sockmap_listen/sockmap IPv6 TCP test_reuseport_mixed_groups:OK
#213/72  sockmap_listen/sockmap IPv6 UDP test_reuseport_select_listening:OK
#213/73  sockmap_listen/sockmap IPv6 UDP test_reuseport_select_connected:OK
#213/74  sockmap_listen/sockmap IPv6 UDP test_reuseport_mixed_groups:OK
#213/75  sockmap_listen/sockmap IPv6 test_udp_redir:OK
#213/76  sockmap_listen/sockmap IPv6 test_udp_unix_redir:OK
#213/77  sockmap_listen/sockmap Unix test_unix_redir:OK
#213/78  sockmap_listen/sockmap Unix test_unix_redir:OK
./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
#213/79  sockmap_listen/sockmap VSOCK test_vsock_redir:FAIL
#213/80  sockmap_listen/sockhash IPv4 TCP test_insert_invalid:OK
#213/81  sockmap_listen/sockhash IPv4 TCP test_insert_opened:OK
#213/82  sockmap_listen/sockhash IPv4 TCP test_insert_bound:OK
#213/83  sockmap_listen/sockhash IPv4 TCP test_insert:OK
#213/84  sockmap_listen/sockhash IPv4 TCP test_delete_after_insert:OK
#213/85  sockmap_listen/sockhash IPv4 TCP test_delete_after_close:OK
#213/86  sockmap_listen/sockhash IPv4 TCP test_lookup_after_insert:OK
#213/87  sockmap_listen/sockhash IPv4 TCP test_lookup_after_delete:OK
#213/88  sockmap_listen/sockhash IPv4 TCP test_lookup_32_bit_value:OK
#213/89  sockmap_listen/sockhash IPv4 TCP test_update_existing:OK
#213/90  sockmap_listen/sockhash IPv4 TCP test_destroy_orphan_child:OK
#213/91  sockmap_listen/sockhash IPv4 TCP test_syn_recv_insert_delete:OK
#213/92  sockmap_listen/sockhash IPv4 TCP test_race_insert_listen:OK
#213/93  sockmap_listen/sockhash IPv4 TCP test_clone_after_delete:OK
#213/94  sockmap_listen/sockhash IPv4 TCP test_accept_after_delete:OK
#213/95  sockmap_listen/sockhash IPv4 TCP test_accept_before_delete:OK
#213/96  sockmap_listen/sockhash IPv4 UDP test_insert_invalid:OK
#213/97  sockmap_listen/sockhash IPv4 UDP test_insert_opened:OK
#213/98  sockmap_listen/sockhash IPv4 UDP test_insert:OK
#213/99  sockmap_listen/sockhash IPv4 UDP test_delete_after_insert:OK
#213/100 sockmap_listen/sockhash IPv4 UDP test_delete_after_close:OK
#213/101 sockmap_listen/sockhash IPv4 UDP test_lookup_after_insert:OK
#213/102 sockmap_listen/sockhash IPv4 UDP test_lookup_after_delete:OK
#213/103 sockmap_listen/sockhash IPv4 UDP test_lookup_32_bit_value:OK
#213/104 sockmap_listen/sockhash IPv4 UDP test_update_existing:OK
#213/105 sockmap_listen/sockhash IPv4 test_skb_redir_to_connected:OK
#213/106 sockmap_listen/sockhash IPv4 test_skb_redir_to_listening:OK
#213/107 sockmap_listen/sockhash IPv4 test_skb_redir_partial:OK
#213/108 sockmap_listen/sockhash IPv4 test_msg_redir_to_connected:OK
#213/109 sockmap_listen/sockhash IPv4 test_msg_redir_to_listening:OK
#213/110 sockmap_listen/sockhash IPv4 TCP test_reuseport_select_listening:OK
#213/111 sockmap_listen/sockhash IPv4 TCP test_reuseport_select_connected:OK
#213/112 sockmap_listen/sockhash IPv4 TCP test_reuseport_mixed_groups:OK
#213/113 sockmap_listen/sockhash IPv4 UDP test_reuseport_select_listening:OK
#213/114 sockmap_listen/sockhash IPv4 UDP test_reuseport_select_connected:OK
#213/115 sockmap_listen/sockhash IPv4 UDP test_reuseport_mixed_groups:OK
#213/116 sockmap_listen/sockhash IPv4 test_udp_redir:OK
#213/117 sockmap_listen/sockhash IPv4 test_udp_unix_redir:OK
#213/118 sockmap_listen/sockhash IPv6 TCP test_insert_invalid:OK
#213/119 sockmap_listen/sockhash IPv6 TCP test_insert_opened:OK
#213/120 sockmap_listen/sockhash IPv6 TCP test_insert_bound:OK
#213/121 sockmap_listen/sockhash IPv6 TCP test_insert:OK
#213/122 sockmap_listen/sockhash IPv6 TCP test_delete_after_insert:OK
#213/123 sockmap_listen/sockhash IPv6 TCP test_delete_after_close:OK
#213/124 sockmap_listen/sockhash IPv6 TCP test_lookup_after_insert:OK
#213/125 sockmap_listen/sockhash IPv6 TCP test_lookup_after_delete:OK
#213/126 sockmap_listen/sockhash IPv6 TCP test_lookup_32_bit_value:OK
#213/127 sockmap_listen/sockhash IPv6 TCP test_update_existing:OK
#213/128 sockmap_listen/sockhash IPv6 TCP test_destroy_orphan_child:OK
#213/129 sockmap_listen/sockhash IPv6 TCP test_syn_recv_insert_delete:OK
#213/130 sockmap_listen/sockhash IPv6 TCP test_race_insert_listen:OK
#213/131 sockmap_listen/sockhash IPv6 TCP test_clone_after_delete:OK
#213/132 sockmap_listen/sockhash IPv6 TCP test_accept_after_delete:OK
#213/133 sockmap_listen/sockhash IPv6 TCP test_accept_before_delete:OK
#213/134 sockmap_listen/sockhash IPv6 UDP test_insert_invalid:OK
#213/135 sockmap_listen/sockhash IPv6 UDP test_insert_opened:OK
#213/136 sockmap_listen/sockhash IPv6 UDP test_insert:OK
#213/137 sockmap_listen/sockhash IPv6 UDP test_delete_after_insert:OK
#213/138 sockmap_listen/sockhash IPv6 UDP test_delete_after_close:OK
#213/139 sockmap_listen/sockhash IPv6 UDP test_lookup_after_insert:OK
#213/140 sockmap_listen/sockhash IPv6 UDP test_lookup_after_delete:OK
#213/141 sockmap_listen/sockhash IPv6 UDP test_lookup_32_bit_value:OK
#213/142 sockmap_listen/sockhash IPv6 UDP test_update_existing:OK
#213/143 sockmap_listen/sockhash IPv6 test_skb_redir_to_connected:OK
#213/144 sockmap_listen/sockhash IPv6 test_skb_redir_to_listening:OK
#213/145 sockmap_listen/sockhash IPv6 test_skb_redir_partial:OK
#213/146 sockmap_listen/sockhash IPv6 test_msg_redir_to_connected:OK
#213/147 sockmap_listen/sockhash IPv6 test_msg_redir_to_listening:OK
#213/148 sockmap_listen/sockhash IPv6 TCP test_reuseport_select_listening:OK
#213/149 sockmap_listen/sockhash IPv6 TCP test_reuseport_select_connected:OK
#213/150 sockmap_listen/sockhash IPv6 TCP test_reuseport_mixed_groups:OK
#213/151 sockmap_listen/sockhash IPv6 UDP test_reuseport_select_listening:OK
#213/152 sockmap_listen/sockhash IPv6 UDP test_reuseport_select_connected:OK
#213/153 sockmap_listen/sockhash IPv6 UDP test_reuseport_mixed_groups:OK
#213/154 sockmap_listen/sockhash IPv6 test_udp_redir:OK
#213/155 sockmap_listen/sockhash IPv6 test_udp_unix_redir:OK
#213/156 sockmap_listen/sockhash Unix test_unix_redir:OK
#213/157 sockmap_listen/sockhash Unix test_unix_redir:OK
./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
#213/158 sockmap_listen/sockhash VSOCK test_vsock_redir:FAIL
#213     sockmap_listen:FAIL

All error logs:
./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
#213/79  sockmap_listen/sockmap VSOCK test_vsock_redir:FAIL
./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
vsock_unix_redir_connectible:FAIL:1501
#213/158 sockmap_listen/sockhash VSOCK test_vsock_redir:FAIL
#213     sockmap_listen:FAIL
Summary: 0/156 PASSED, 0 SKIPPED, 1 FAILED
[   18.853649] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   18.854041] #PF: supervisor write access in kernel mode
[   18.854337] #PF: error_code(0x0002) - not-present page
[   18.854605] PGD 104826067 P4D 104826067 PUD 104825067 PMD 0
[   18.854918] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   18.855171] CPU: 3 PID: 50 Comm: kworker/3:1 Tainted: G           OE      6.5.0+ #8
[   18.855592] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[   18.856051] Workqueue: events sk_psock_destroy
[   18.856294] RIP: 0010:skb_dequeue+0x4b/0x70
[   18.856524] Code: 74 45 4d 85 e4 74 40 8b 43 10 83 e8 01 89 43 10 49 8b 14 24 49 8b 44 24 08 49 c7 04 24 00 00 00 00 49 c7 44 24 08 00 00 00 00 <48> 89 42 08 48 89 10 4c 89 ef e8 e6 24 3b 00 4c 89 e0 5b 41 5c 41
[   18.857516] RSP: 0018:ffffc900002cbdc0 EFLAGS: 00010097
[   18.857798] RAX: 0000000000000000 RBX: ffff88810685e1b8 RCX: 363a88e2d5498366
[   18.858186] RDX: 0000000000000000 RSI: 0000000000000282 RDI: ffff88810685e1d0
[   18.858568] RBP: ffffc900002cbdd8 R08: 0000000000000000 R09: 0000000000080000
[   18.858961] R10: 0000000000000394 R11: 0000000000000001 R12: ffff888102468b00
[   18.859346] R13: ffff88810685e1d0 R14: ffff8881003da000 R15: ffff88810685e438
[   18.859735] FS:  0000000000000000(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
[   18.860177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.860486] CR2: 0000000000000008 CR3: 000000010480e005 CR4: 0000000000770ea0
[   18.860868] PKRU: 55555554
[   18.861017] Call Trace:
[   18.861155]  <TASK>
[   18.861273]  ? show_regs+0x60/0x70
[   18.861468]  ? __die+0x1f/0x70
[   18.861633]  ? page_fault_oops+0x80/0x160
[   18.861845]  ? do_user_addr_fault+0x320/0x7b0
[   18.862084]  ? __this_cpu_preempt_check+0x13/0x20
[   18.862348]  ? exc_page_fault+0x70/0x1c0
[   18.862562]  ? asm_exc_page_fault+0x27/0x30
[   18.862785]  ? skb_dequeue+0x4b/0x70
[   18.862986]  sk_psock_destroy+0x88/0x2e0
[   18.863205]  process_one_work+0x264/0x550
[   18.863420]  worker_thread+0x4d/0x3c0
[   18.863624]  ? process_one_work+0x550/0x550
[   18.863855]  kthread+0x106/0x140
[   18.864031]  ? kthread_complete_and_exit+0x20/0x20
[   18.864281]  ret_from_fork+0x35/0x60
[   18.864480]  ? kthread_complete_and_exit+0x20/0x20
[   18.864730]  ret_from_fork_asm+0x11/0x20
[   18.864948]  </TASK>
[   18.865075] Modules linked in: bpf_testmod(OE)
[   18.865320] CR2: 0000000000000008
[   18.865493] ---[ end trace 0000000000000000 ]---
[   18.865746] RIP: 0010:skb_dequeue+0x4b/0x70
[   18.865976] Code: 74 45 4d 85 e4 74 40 8b 43 10 83 e8 01 89 43 10 49 8b 14 24 49 8b 44 24 08 49 c7 04 24 00 00 00 00 49 c7 44 24 08 00 00 00 00 <48> 89 42 08 48 89 10 4c 89 ef e8 e6 24 3b 00 4c 89 e0 5b 41 5c 41
[   18.866968] RSP: 0018:ffffc900002cbdc0 EFLAGS: 00010097
[   18.867246] RAX: 0000000000000000 RBX: ffff88810685e1b8 RCX: 363a88e2d5498366
[   18.867638] RDX: 0000000000000000 RSI: 0000000000000282 RDI: ffff88810685e1d0
[   18.868028] RBP: ffffc900002cbdd8 R08: 0000000000000000 R09: 0000000000080000
[   18.868407] R10: 0000000000000394 R11: 0000000000000001 R12: ffff888102468b00
[   18.868801] R13: ffff88810685e1d0 R14: ffff8881003da000 R15: ffff88810685e438
[   18.869190] FS:  0000000000000000(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
[   18.869624] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.869944] CR2: 0000000000000008 CR3: 000000010480e005 CR4: 0000000000770ea0
[   18.870327] PKRU: 55555554
[   18.870486] Kernel panic - not syncing: Fatal exception
[   18.870856] Kernel Offset: disabled

