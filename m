Return-Path: <bpf+bounces-10389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214407A65EB
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 15:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB072823D1
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B788A38DC1;
	Tue, 19 Sep 2023 13:55:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D97374F0
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 13:55:20 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32197EC
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=JoaEgRHy2h6LrgPYtDjiUam+FDKV4FRvmn8jFRuYC/s=; b=F/Dijo5tjNPpe
	GQSXRiycx0j8Aq5hJjMV/meLv2cXMtaSXyH+FeoShrN8ddC2x5E9lq25dXzKRyIk
	6Ux1QS9J7/dVYcFZ/qTmrxhudPt7T2Naq9PDqPqpr2syRpkwq9i4FP2dmWBjYRSU
	YgZL+j2XnAhPnJokBmA5oiEacgtTfY=
Received: from chang-liu22$mails.tsinghua.edu.cn ( [101.5.9.34] ) by
 ajax-webmail-web5 (Coremail) ; Tue, 19 Sep 2023 21:55:00 +0800 (GMT+08:00)
X-Originating-IP: [101.5.9.34]
Date: Tue, 19 Sep 2023 21:55:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5YiY55WF?= <chang-liu22@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Subject: Is is possible to get the function calling stack in an fentry bpf
 program?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <49b9b6f.1279.18aadb90e05.Coremail.chang-liu22@mails.tsinghua.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zAQGZQB3kxM0qAllOmm9AA--.16013W
X-CM-SenderInfo: xfkd0wonol3j2s6ptxtovo32xlqjx3vdohv3gofq/1tbiAgQTAGUJ
	liUY7QAAs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgYWxsCgpJIGF0dGFjaGVkIGFuIGZlbnRyeSBlQlBGIHByb2dyYW0gdG8gYSBrZXJuZWwgZnVu
Y3Rpb24sIGkuZS4sIHRjcF90cmFuc21pdF9za2IoKS4gSSB3YW50IHRvIGltcGxlbWVudCBkaWZm
ZXJlbnQgbG9naWMgaW4gdGhlIGJwZiBwcm9ncmFtIGZvciBkaWZmZXJlbnQgY2FsbGluZyBzdGFj
ayBjYXNlcywgZS5nLiwgX190Y3BfcmV0cmFuc21pdF9za2IoKS0+dGNwX3RyYW5zbWl0X3NrYigp
IGFuZCB0Y3Bfd3JpdGVfeG1pdCgpLT50Y3BfdHJhbnNtaXRfc2tiKCkuIEkga25vdyB0aGF0IEkg
Y2FuIGFjY2VzcyBzdGFjayB0cmFjZXMgdXNpbmcgdGhlIGJwZl9nZXRfc3RhY2soKSBoZWxwZXIg
ZnVuY3Rpb24uIEhvd2V2ZXIsIGluIHRoZSBmZW50cnkgZUJQRiBwcm9ncmFtLCBJIGRvbid0IGtu
b3cgdGhlIHZhbHVlIG9mIHRoZSBSU1AgYW5kIFJCUCByZWdpc3Rlciwgd2hpY2ggbWVhbnMgSSBj
YW4gbm90IGxvY2F0ZSB0aGUgcmV0dXJuIGFkZHJlc3MgZXZlbiBpZiBJIGNhbiBnZXQgdGhlIHN0
YWNrIHRyYWNlcy4gSSB3YW50IHRvIGtub3cgaWYgdGhlcmUncyBhbnkgd2F5IHRoYXQgSSBjYW4g
Z2V0IHRoZSByZXR1cm4gYWRkcmVzcyBhbmQgdGh1cyBnZXQgdGhlIGZ1bmN0aW9uIGNhbGxpbmcg
c3RhY2sgaW4gYW4gZmVudHJ5IGJwZiBwcm9ncmFtLiAKCkknZCBiZSBhcHByZWNpYXRlIGlmIHlv
dSBjYW4gaGVscCBtZS4KCkNoYW5nIExpdQpUc2luZ2h1YSBVbml2ZXJzaXR5LCBDaGluYQ==

