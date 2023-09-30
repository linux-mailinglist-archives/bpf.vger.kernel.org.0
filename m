Return-Path: <bpf+bounces-11161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA77B41DA
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 17:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6C31E283529
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2AE17738;
	Sat, 30 Sep 2023 15:48:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C28F52
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 15:48:38 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22005AC
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 08:48:36 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EEECEC17CE9D
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696088915; bh=sPOYa6sp499VmDmfVExATfLXRAMX6n2VKd+VJyMDsyI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=iMxXEorMZME0AnCs+/XeN3gVxBeCtBvAcS+uCPPsZiQjKNhqR6pgdSmto46xkdaDS
	 5N7GEwTXx58aslvLIAgNtMxzCok3ovp58E3YM+g6VrjFtIWe27p7MGmZOTTIw5KLDc
	 ME/voq23f+s0Pvfu5DqZ9JUaQ2fnSCCF+lp3JBz8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Sep 30 08:48:35 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C9D52C14CE4D;
	Sat, 30 Sep 2023 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696088915; bh=sPOYa6sp499VmDmfVExATfLXRAMX6n2VKd+VJyMDsyI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=iMxXEorMZME0AnCs+/XeN3gVxBeCtBvAcS+uCPPsZiQjKNhqR6pgdSmto46xkdaDS
	 5N7GEwTXx58aslvLIAgNtMxzCok3ovp58E3YM+g6VrjFtIWe27p7MGmZOTTIw5KLDc
	 ME/voq23f+s0Pvfu5DqZ9JUaQ2fnSCCF+lp3JBz8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D1B5BC14EB17
 for <bpf@ietfa.amsl.com>; Sat, 30 Sep 2023 08:48:33 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.106
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4TAKacwWEHJl for <bpf@ietfa.amsl.com>;
 Sat, 30 Sep 2023 08:48:31 -0700 (PDT)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id BFA48C14CE4D
 for <bpf@ietf.org>; Sat, 30 Sep 2023 08:48:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-406402933edso67927725e9.2
 for <bpf@ietf.org>; Sat, 30 Sep 2023 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696088910; x=1696693710; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PK5+3t0RJRwjjtBlkND07xhScJ0eD36iRg6LirUJ+Cc=;
 b=TWrm6HOudje8/YP4Y3Mc8sZzP5CZWlb52T6B0PmwJzyeG6e7LA2awmUsECQRyKJpGe
 0UDydDmVWauEVrOTxSD3pyLqyrxbjOOnW4cCqN5s2npwzuiUbf4eFMiCP31S0VjMSHIE
 LKaOfr/qf84RK9WTYGSXsxBeFuwzaVBTi0v/ivTXc+CEH/JAitQ/MKq1iWD4GmIei8wp
 eXXg4W4iZI6UD4zsO0+PUH/fy1GV1wjjVMfNkGXGpXFC8YzM/d2NSQri2FIdVubC7OMV
 NhKv1SIX5VI/N0SO35eFioKARJvxKZFi6nno7tQ7M9XWsiN1u9hC0WAJF2mobMsMzq0b
 Mn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696088910; x=1696693710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PK5+3t0RJRwjjtBlkND07xhScJ0eD36iRg6LirUJ+Cc=;
 b=UPJZ5fzMDqCAXARjthuBOKva2SmnMcwro7dfWBffpTvxXceMekW35ngw8DIhniROz4
 YGqNXPubdr1Xu4QeicgzB1B/uMBbxxN+96Ns56TFsEVhVsNp6iILYfthnSSiai/BLUp+
 pxd9EsUs+/Rf+jKBVvuK9I+UR5LVBJTsZiM1rXThCraGl6eBum9GW4vFGsMCOvGDxUT9
 OFLYwzXck7JffKuTZEflY30mPodajYHqMQSGevogNze07CPac+nXnxSdpkIQp40du+hD
 HlX+M69EczrxcTEqN9BkkmWcnfECskP99bljcaMyF/yPrTRz8Ped/Qshl+xhncvIwCc6
 uXlw==
X-Gm-Message-State: AOJu0YyKZlcI1mrZaBIoXC0+W7tWR0IaJ+Ds3h/COkdHijl172CC18Ke
 xSUz4+BWCGW1tWioVa2008vg1MeISWfBlFwL4TE=
X-Google-Smtp-Source: AGHT+IFXz0a0gbubac84HUCwyzjkFoZsnivdfYxrZcn8Hzjwf2OiudFzZwI+KA8ooQP4PRAIycnwavw4OvQV6NFNzPU=
X-Received: by 2002:adf:e583:0:b0:317:3f70:9dc4 with SMTP id
 l3-20020adfe583000000b003173f709dc4mr6237808wrm.31.1696088909660; Sat, 30 Sep
 2023 08:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 30 Sep 2023 08:48:18 -0700
Message-ID: <CAADnVQL69iqzxsNRDLKW22B=3sJpO0Yy2yHzioWZmhtQvUwtTQ@mail.gmail.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/uiDbLYYDolIaEx0-VkPSgT70KCU>
Subject: Re: [Bpf] ISA RFC compliance question
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCBTZXAgMjksIDIwMjMgYXQgMToxN+KAr1BNIERhdmUgVGhhbGVyCjxkdGhhbGVyPTQw
bWljcm9zb2Z0LmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6Cj4KPiBbZml4aW5nIHdlaXJkIGNo
YXJhY3RlciBpc3N1ZSBpbiBlbWFpbCBiZWxvdyB0aGF0IGNhdXNlZCBhIGJvdW5jZV0KPgo+IE5v
dyB0aGF0IHdlIGhhdmUgc29tZSBuZXcgInY0IiBpbnN0cnVjdGlvbnMsIGl0IHNlZW1zIGEgZ29v
ZCB0aW1lIHRvIGFzayBhYm91dAo+IHdoYXQgaXQgbWVhbnMgdG8gc3VwcG9ydCAob3IgY29tcGx5
IHdpdGgpIHRoZSBJU0EgUkZDIG9uY2UgcHVibGlzaGVkLiAgRG9lcwo+IGl0IG1lYW4gdGhhdCBh
IHZlcmlmaWVyL2Rpc2Fzc2VtYmxlci9KSVQgY29tcGlsZXIvZXRjLiBNVVNUIHN1cHBvcnQgKmFs
bCogdGhlCj4gbm9uLWRlcHJlY2F0ZWQgaW5zdHJ1Y3Rpb25zIGluIHRoZSBkb2N1bWVudD8gICBU
aGF0IGlzIGFueSBydW50aW1lIG9yIHRvb2wgdGhhdAo+IGRvZXNuJ3Qgc3VwcG9ydCB0aGUgbmV3
IGluc3RydWN0aW9ucyBpcyBjb25zaWRlcmVkIG5vbi1jb21wbGlhbnQgd2l0aCB0aGUgQlBGIElT
QT8KCkluIHRoZSBsaW51eCBrZXJuZWwgbm90IGFsbCBKSVRzIHN1cHBvcnQgYWxsIGluc3RydWN0
aW9ucy4KVGhhdCB3YXMgdGhlIGNhc2UgZXZlbiBiZWZvcmUgdjQgYWRkaXRpb25zLgpTYW1lIGdv
ZXMgZm9yIHZhcmlvdXMgdXNlciBzcGFjZSB0b29scy4KCj4gT3Igc2hvdWxkIHdlIGNyZWF0ZSBz
b21lIHRoaW5ncyB0aGF0IGFyZSBTSE9VTERzLCBvciBmaW5lciBncmFpbmVkIHVuaXRzIG9mCj4g
Y29tcGxpYW5jZSBzbyBhcyB0byBub3QgZGVjbGFyZSBleGlzdGluZyBkZXBsb3ltZW50cyBub24t
Y29tcGxpYW50PwoKSSBzdXNwZWN0ICdub24tY29tcGxpYW5jZScgbGFiZWwgd2lsbCBjYXVzZSBh
biB1bm5lY2Vzc2FyeSBiYWNrbGFzaCwKc28gSSB3b3VsZCBnbyB3aXRoIFNIT1VMRCB3b3JkaW5n
LgoKPiBQcmV2aW91c2x5IHdlIG9ubHkgdGFsa2VkIGFib3V0IGNhc2VzIHdoZXJlIGluc3RydWN0
aW9ucyB3ZXJlIGFkZGVkIGluIGFuCj4gZXh0ZW5zaW9uIFJGQyB3aGljaCB3b3VsZCBuYXR1cmFs
bHkgcHJvdmlkZSBhIHNlcGFyYXRlIFJGQyB0byBjb25mb3JtIHRvLgo+IEJ1dCBJIGRvbid0IHRo
aW5rIHdlIGRpc2N1c3NlZCB0aGluZ3MgbGlrZSBuZXcgaW5zdHJ1Y3Rpb25zIGluIHRoZSBtYWlu
IHNwZWMgbGlrZQo+IHdlIGhhdmUgbm93Lgo+Cj4gRGF2ZQo+Cj4gLS0KPiBCcGYgbWFpbGluZyBs
aXN0Cj4gQnBmQGlldGYub3JnCj4gaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5m
by9icGYKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRm
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

