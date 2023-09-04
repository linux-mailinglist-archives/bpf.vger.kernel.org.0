Return-Path: <bpf+bounces-9183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171379165D
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 13:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5E9280EA1
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB64433;
	Mon,  4 Sep 2023 11:45:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFB3C20
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 11:45:41 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47B121AB;
	Mon,  4 Sep 2023 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JMU8s
	U9ZldyZxdWa5jQ9IPJKvYaT1NQUbvws9N83oNc=; b=SekLazFZMqmJVUa94F4Az
	XY12XNjBRGuDWAR5DyWO6TFu8gZFaT8e57RxeSA84K2AYRO6tv2Tl/ky3mA55Cbo
	pe9sjOF1r3bukVWITPOuNi0W2mE4wOhZ//4mi1PXQrz6wsMoT8lp/95Mn7e5RDJK
	xIuWrl1HUAqn3J36Z/TVP0=
Received: from localhost.localdomain (unknown [111.35.184.199])
	by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wA31JCSv_VkIMm5BA--.20917S4;
	Mon, 04 Sep 2023 19:29:39 +0800 (CST)
From: David Wang <00107082@163.com>
To: fw@strlen.de
Cc: 00107082@163.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: 
Date: Mon,  4 Sep 2023 19:29:22 +0800
Message-Id: <20230904112922.13882-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230904104856.GE11802@breakpoint.cc>
References: <20230904104856.GE11802@breakpoint.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA31JCSv_VkIMm5BA--.20917S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4DZF45Xr1DXF4kZFyxKrg_yoW8Gr47pa
	y5GaySka1UJF4fKFn7Wry7Za4IyrZ5Za45Jws8tayjk3y3Xry2gw1vkFW0krWfZ3W8Ww1a
	vFWj9w1rJws3A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UUpnQUUUUU=
X-Originating-IP: [111.35.184.199]
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEAfgqmNfu9Xd3gAAsM
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

At 2023-09-04 18:48:56, "Florian Westphal" <fw@strlen.de> wrote:
>David Wang <00107082@163.com> wrote:
>> This sample code implements a simple ipv4
>> blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
>> which was introduced in 6.4.
>> 
>> The bpf program drops package if destination ip address
>> hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,
>> 
>> The userspace code would load the bpf program,
>> attach it to netfilter's FORWARD/OUTPUT hook,
>> and then write ip patterns into the bpf map.
>
>Thanks, I think its good to have this.

Thanks for the quick response! Glad to contribute!

>> +
>> +#define NF_DROP 0
>> +#define NF_ACCEPT 1
>
>If you are interested, you could send a patch for nf-next that
>makes the uapi headers expose this as enum, AFAIU that would make
>the verdict nanes available via vmlinux.h.
>

I think I can work on this.


>> +	if (pvalue) {
>> +		/* cat /sys/kernel/debug/tracing/trace_pipe */
>> +		bpf_printk("rule matched with %d...\n", *pvalue);
>
>If you are interested you could send a patch that adds a kfunc to
>nf_bpf_link that exposes nf_log_packet() to bpf.
>
>nf_log_packet has a terrible api, I suggest to have the kfunc take
>'struct nf_hook_state *' instead of 6+ members of that struct as
>argument.
>

Package logging strategy is out of my league, for now, but I will keep eye on this.


David


