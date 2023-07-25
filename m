Return-Path: <bpf+bounces-5782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155AE7603A4
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF61C20CF3
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B31106;
	Tue, 25 Jul 2023 00:13:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A8EA4
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:13:17 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61C37171E
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:13:11 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.162.208.50] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 25 Jul 2023 08:12:42 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.208.50]
Date: Tue, 25 Jul 2023 08:12:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	ast@kernel.org, martin.lau@kernel.org, yhs@fb.com, andrii@kernel.org, 
	void@manifault.com, houtao1@huawei.com, laoar.shao@gmail.com, 
	inwardvessel@gmail.com, kuniyu@amazon.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230724151507.6b725396@kernel.org>
References: <20230723075452.3711158-1-linma@zju.edu.cn>
 <20230724151507.6b725396@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4e56edca.e264e.1898a641853.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgBXX4t6E79kW1WACg--.28456W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMHEmS91fkWAgAAs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgSmFrdWIsCgo+IAo+IFlvdSBjYW4gbW92ZSB0aGlzIGNoZWNrIGVhcmxpZXIsIHdoZW4gdGhl
IGF0dHJpYnV0ZXMgYXJlIGdldHRpbmcKPiBjb3VudGVkLiBUaGF0IHdheSB3ZSBjYW4gYXZvaWQg
dGhlIGFsbG9jL2ZyZWUgb24gZXJyb3IuCgpHb29kIHBvaW50LCB3aWxsIGZpeCB0aGF0IGFuZCBw
cmVwYXJlIGFub3RoZXIgcGF0Y2gKClRoYW5rcwpMaW4=

