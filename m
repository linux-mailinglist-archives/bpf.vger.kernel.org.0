Return-Path: <bpf+bounces-598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5447043EB
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 05:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589C31C20ACA
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 03:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408112592;
	Tue, 16 May 2023 03:25:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655C23BD
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 03:25:48 +0000 (UTC)
Received: from cu-ua11p00im-quki07170902.ua.silu.net (cu-ua11p00im-quki07170902.ua.silu.net [123.126.78.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C1B421D
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 20:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1ca1ba; t=1684207539;
	bh=KEZeUHJhk9HszdCnVwEd3gTTnYvEiu6RYQKj6I53OY4=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:To:Date;
	b=mhCKy1u2sQNcVJn3fbFyNuoEMyighf12QFVbFy9jfzqrBWTAfOkES1iqPuUahCLGK
	 /fFIPQuHFQT+XhQqyhJhi83Wdb7qEzbwfxLsNXdKAz1Sd58EBt3ubPdVuq9bIPgf2/
	 n+gTJUA/lQ4BMwfMAsV4++g6oyMILBw5FOXmxOv+7BWW+mlgIHx+C7LHF++vx/ENAm
	 q4PPh/TvLLPd/W+hxrnOhKn7xhxfVLCo8QvqyUnb0Fi6CXXYD+n6Vp+YfxIrV0OSZb
	 3N948vglXlw7C9pk/hpJo0uOSpjLumybDOibpwuOR6clN6R8VAACxMPuGL4xwDgwak
	 gUBDhSDlesRGA==
Received: from smtpclient.apple (unknown [140.205.102.125])
	by ua11p00im-quki07170902.ua.silu.net (Postfix) with ESMTPS id D1C2A300185
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 03:25:37 +0000 (UTC)
From: chen.yunxing@icloud.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: add helper to get value of Thread Local Storage base register
Message-Id: <6AAA2A54-2161-447E-BEFB-BE92281A1EB0@icloud.com>
References: <EE887B7B-BAC1-4D59-8752-ACD8705725F4@icloud.com>
To: bpf@vger.kernel.org
Date: Tue, 16 May 2023 11:25:24 +0800
X-Mailer: Apple Mail (2.3731.500.231)
X-Proofpoint-GUID: nvd0PfIEcuDP2qnONXjI3jGPDWsW2dSD
X-Proofpoint-ORIG-GUID: nvd0PfIEcuDP2qnONXjI3jGPDWsW2dSD
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.528,18.0.895,17.11.122.1.0000000_definitions=3D?=
 =?UTF-8?Q?2022-09-21=5F11:2022-09-20=5F02,2022-09-21=5F11,2022-06-22=5F01?=
 =?UTF-8?Q?_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=491
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2305160026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,=20

I want to discuss the requirement of add bpf helper:

for the purpose of accessing user space variable of TLS(Thread Local =
Storage)=EF=BC=8Cwe need get the TLS register of current Thread/Task.

then the TLS variable can be accessed via add offset to this register =
(as the base)

for example at arm:

mrs x0, tpidr_el0=

