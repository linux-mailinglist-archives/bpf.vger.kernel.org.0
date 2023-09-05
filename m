Return-Path: <bpf+bounces-9244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED75792212
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 13:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AE5281107
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED33CA6F;
	Tue,  5 Sep 2023 11:11:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32DCA49
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 11:11:47 +0000 (UTC)
Received: from m1388.mail.163.com (m1388.mail.163.com [220.181.13.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 907541AB;
	Tue,  5 Sep 2023 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=AnoszC4Wf0HgzM7XYH9pKyosfCmKtyeLWNv6taO6AUI=; b=W
	FoI5zsiATykTn77Ph2c6rJ7H9vnHj6kA8fJez8bRF02zQThvvaio/Oa8cqancqwb
	cRCRUrDXZzIG3UI0gXw28gLSdrE0n6957grUWclUckB1ie/3I3Bce6Bkeouu8fGl
	vjPItgeHNIz9L6FyVeW13lyfmrS6HMh2jjvvjDcRhg=
Received: from 00107082$163.com ( [111.35.184.199] ) by ajax-webmail-wmsvr88
 (Coremail) ; Tue, 5 Sep 2023 19:09:03 +0800 (CST)
X-Originating-IP: [111.35.184.199]
Date: Tue, 5 Sep 2023 19:09:03 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Florian Westphal" <fw@strlen.de>, "Alexei Starovoitov" <ast@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Andrii Nakryiko" <andrii@kernel.org>, 
	"Martin KaFai Lau" <martin.lau@linux.dev>, 
	"Song Liu" <song@kernel.org>, 
	"Yonghong Song" <yonghong.song@linux.dev>, 
	"John Fastabend" <john.fastabend@gmail.com>, 
	"KP Singh" <kpsingh@kernel.org>, 
	"Stanislav Fomichev" <sdf@google.com>, "Hao Luo" <haoluo@google.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] samples/bpf: Add sample usage for
 BPF_PROG_TYPE_NETFILTER
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
References: <20230904102128.11476-1-00107082@163.com>
 <20230904104856.GE11802@breakpoint.cc>
 <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
X-NTES-SC: AL_QuySAfWavUkv5SeYbekZnEYQheY4XMKyuPkg1YJXOp80oyr99Q0sT01nIlv0y/OUNDKKgiqbeQhXx9RqQbBzZoiVTmO+wEnN8eHQPL7ak4kW
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5490ca67.552d.18a6508175f.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:WMGowABns5hQDPdkjk0AAA--.3984W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEAThqmNfu+chxgAJsR
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CgoKCgoKCgoKCgpBdCAyMDIzLTA5LTA1IDA1OjAxOjE0LCAiQWxleGVpIFN0YXJvdm9pdG92IiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj5PbiBNb24sIFNlcCA0LCAyMDIz
IGF0IDM6NDnigK9BTSBGbG9yaWFuIFdlc3RwaGFsIDxmd0BzdHJsZW4uZGU+IHdyb3RlOgo+Pgo+
PiBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToKPj4gPiBUaGlzIHNhbXBsZSBj
b2RlIGltcGxlbWVudHMgYSBzaW1wbGUgaXB2NAo+PiA+IGJsYWNrbGlzdCB2aWEgdGhlIG5ldyBi
cGYgdHlwZSBCUEZfUFJPR19UWVBFX05FVEZJTFRFUiwKPj4gPiB3aGljaCB3YXMgaW50cm9kdWNl
ZCBpbiA2LjQuCj4+ID4KPj4gPiBUaGUgYnBmIHByb2dyYW0gZHJvcHMgcGFja2FnZSBpZiBkZXN0
aW5hdGlvbiBpcCBhZGRyZXNzCj4+ID4gaGl0cyBhIG1hdGNoIGluIHRoZSBtYXAgb2YgdHlwZSBC
UEZfTUFQX1RZUEVfTFBNX1RSSUUsCj4+ID4KPj4gPiBUaGUgdXNlcnNwYWNlIGNvZGUgd291bGQg
bG9hZCB0aGUgYnBmIHByb2dyYW0sCj4+ID4gYXR0YWNoIGl0IHRvIG5ldGZpbHRlcidzIEZPUldB
UkQvT1VUUFVUIGhvb2ssCj4+ID4gYW5kIHRoZW4gd3JpdGUgaXAgcGF0dGVybnMgaW50byB0aGUg
YnBmIG1hcC4KPj4KPj4gVGhhbmtzLCBJIHRoaW5rIGl0cyBnb29kIHRvIGhhdmUgdGhpcy4KPgo+
WWVzLCBidXQgb25seSBpbiBzZWxmdGVzdHMvYnBmLgo+c2FtcGxlcy9icGYvIGFyZSBub3QgdGVz
dGVkIGFuZCBiaXQgcm90IGhlYXZpbHkuCgpIaSBBbGV4ZWksIAoKSSBuZWVkIHRvIGtub3cgd2hl
dGhlciBzYW1wbGVzL2JwZiBpcyBzdGlsbCBhIGdvb2QgcGxhY2UgdG8gcHV0IGNvZGUuIApJIHdp
bGwgcHV0IHRoZSBjb2RlIGluIGFub3RoZXIgb3BlbiBzb3VyY2UgcHJvamVjdCAgZm9yIGJwZiBz
YW1wbGVzLCAgbWVudGlvbmVkIGJ5IFRva2UuCkJ1dCBJIHN0aWxsIHdhbnQgdG8gcHV0IGl0IGlu
IHNhbXBsZXMvYnBmICwgc2luY2UgdGhlIGNvZGUgb25seSBjb21waWxlL3dvcmsgd2l0aCBuZXcg
a2VybmVsLgoKTmVlZCB5b3VyIGZlZWRiYWNrIG9uIHRoaXMsICBjb3VsZCB0aGlzIGNvZGUgYmUg
a2VwdCBpbiBzYW1wbGVzL2JwZj8gOikKClRoYW5rcwpEYXZpZC4=

