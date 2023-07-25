Return-Path: <bpf+bounces-5796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3DF760931
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 07:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD761C20DC4
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13878833;
	Tue, 25 Jul 2023 05:24:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090679C4;
	Tue, 25 Jul 2023 05:24:59 +0000 (UTC)
X-Greylist: delayed 18711 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 22:24:55 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2A72116;
	Mon, 24 Jul 2023 22:24:55 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.62] ) by
 ajax-webmail-mail-app4 (Coremail) ; Tue, 25 Jul 2023 13:24:38 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.62]
Date: Tue, 25 Jul 2023 13:24:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, ast@kernel.org, martin.lau@kernel.org, yhs@fb.com, 
	void@manifault.com, andrii@kernel.org, houtao1@huawei.com, 
	inwardvessel@gmail.com, kuniyu@amazon.com, songliubraving@fb.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230725044409.GF11388@unreal>
References: <20230725023330.422856-1-linma@zju.edu.cn>
 <20230725044409.GF11388@unreal>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15dc24fc.e7c38.1898b81ac08.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3ybGWXL9kwQAPCg--.53344W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUHEmS-J3oE0gAAsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8gTGVvbiwKCj4gCj4gSmFrdWIsIGl0IHNlZW1zIGxpa2UgTGluIGFkZHMgdGhpcyBjaGVj
ayB0byBhbGwgbmxhX2Zvcl9lYWNoX25lc3RlZCgpIGxvb3BzLgo+IElNSE8sIHRoZSBiZXR0ZXIg
Y2hhbmdlIHdpbGwgYmUgdG8gY2hhbmdlIG5sYV9mb3JfZWFjaF9uZXN0ZWQoKSBza2lwIGVtcHR5
L25vdCB2YWxpZCBOTEFzLgo+IAo+IFRoYW5rcwoKSSBndWVzcyB5b3UganVzdCBnZXQgdGhlc2Ug
Zml4ZXMgbWlzdW5kZXJzdG9vZC4gSSBkbyBub3QgYWRkIHRoZSBubGFfbGVuIGNoZWNrCnRvICAq
KmFsbCBubGFfZm9yX2VhY2hfbmVzdGVkKiogOiguIEkgb25seSBhZGQgY2hlY2tzIHRvIHRob3Nl
IHdobyBkbyBub3QgYWNjZXNzIAp0aGUgYXR0cmlidXRlcyB3aXRob3V0IHZlcmlmeWluZyB0aGUg
bGVuZ3RoLCB3aGljaCBpcyBidWdneS4KClRoZSBvdGhlcnMsIGVpdGhlciBkbyBhIHNpbWlsYXIg
bmxhX2xlbiBjaGVjayBhbHJlYWR5IG9yIGp1c3QgZG8gbmxhX3ZhbGlkYXRlCnNvbWV3aGVyZSBl
bHNlLiBUaGF0IGlzIHRvIHNheSwgdGhleSAqKnZhbGlkYXRlKiogdGhlIHJlbGV2YW50IGF0dHJp
YnV0ZXMuCgpJbiBzaG9ydCwgbmxhX2Zvcl9lYWNoX25lc3RlZCBpcyBqdXN0IGEgbG9vcCBtYWNy
byB0aGF0IGl0ZXJhdGVzIHRoZSBubGF0dHJzLApsaWtlIG5sYV9mb3JfZWFjaCBtYWNyby4gSXQg
aXMgd2VpcmQgZm9yIHRoZW0gdG8gZG8gbmxhdHRyIHZhbGlkYXRpb24gYXMgdGhlcmUKY291bGQg
aGF2ZSBhbHJlYWR5IGJlZW4gYSBjYWxsIHRvIG5sYV92YWxpZGF0ZSB0byBlbnN1cmUgdGhvc2Ug
YXR0cmlidXRlcyBhcmUKY29ycmVjdC4gVGhhdCBpcywgZm9yIHRob3NlIHdobyBkbyBub3QsIGEg
c2ltcGxlIG5sYV9sZW4gY2hlY2sgaXMgdGhlIHNpbXBsZXN0CmFuZCBtb3N0IGVmZmljaWVudCBj
aG9pY2UuCgpSZWdhcmRzCkxpbg==

