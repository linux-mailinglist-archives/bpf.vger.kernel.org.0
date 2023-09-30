Return-Path: <bpf+bounces-11155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73157B4120
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8EAEA2825E2
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0A156F3;
	Sat, 30 Sep 2023 14:48:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6C2C9E
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 14:48:25 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD72B7
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 07:48:24 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 75E5DC17CE99
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696085304; bh=XZFAAERVeSVgo/5QnZ3zMOvIWDXI50y9CppjNWHbDmM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=RhuKvl5pYVnQ6qqUPJtOSEOGp7heJq4DLd8oiCqMDaZ1gzPLCVLGnL6xvhyhYc0+/
	 wjcKzkw52PDXiNUTYDWJPSfwZIAPdn9A2R6qZGeclAWNZDBipEkdOItdjp6m9rwNAW
	 Zoik01h7DYkumb6XpC6s/374L1OlhnFM2LeOSj2w=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Sep 30 07:48:24 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 44432C151991;
	Sat, 30 Sep 2023 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696085304; bh=XZFAAERVeSVgo/5QnZ3zMOvIWDXI50y9CppjNWHbDmM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=RhuKvl5pYVnQ6qqUPJtOSEOGp7heJq4DLd8oiCqMDaZ1gzPLCVLGnL6xvhyhYc0+/
	 wjcKzkw52PDXiNUTYDWJPSfwZIAPdn9A2R6qZGeclAWNZDBipEkdOItdjp6m9rwNAW
	 Zoik01h7DYkumb6XpC6s/374L1OlhnFM2LeOSj2w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 499F4C1524AA
 for <bpf@ietfa.amsl.com>; Sat, 30 Sep 2023 07:48:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.108
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
 with ESMTP id YXF9galy4NPN for <bpf@ietfa.amsl.com>;
 Sat, 30 Sep 2023 07:48:20 -0700 (PDT)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 057ADC151985
 for <bpf@ietf.org>; Sat, 30 Sep 2023 07:48:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40651a726acso28622995e9.1
 for <bpf@ietf.org>; Sat, 30 Sep 2023 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696085298; x=1696690098; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiMfY3k0qZTMV622+opFR1LvgNsLeNjXguRm7yHHHa0=;
 b=fn1jP+RwJpnSeuGj5x7DquzMioyBbzznqGkLCemlgKZrlzRtzkK9KKcGiJxE2DdsyY
 t7ayM9jjed+PYTjicgwlQ1V4jnAvM+R12gTPv2XB3coV7mjCzOLatXpHzSI3yOXVCNvr
 jkADuxJpQUofvcfPgb/6wzCOC5FkMH8pYFHwm3ydTQMYtb15xBvF4jv48jzOP4Q13//H
 713n/vSrONocWIdfqq2VHzhY2mkcoNDwr7JwmCC02NR8syL/q/nRv0kEE7Jw3GZQkwE9
 ZHi+v5OWpsSd/rhCocEvX6xgmFzGKgCgj01QRxvvUFt5Y1WD/Lf3yKZLZ/65XxRYAl/M
 vIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696085298; x=1696690098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiMfY3k0qZTMV622+opFR1LvgNsLeNjXguRm7yHHHa0=;
 b=tOFekAp5ly9oQO6nL7DcBz2VLYbvaGZCIO4BiwIiJpI6m2G9ENIP8wFDdw7KmhHRjn
 nPHGGmKgETeRbyxgSQXLe7b+TOQ51/JfcOCvfg4f6WUHm0vg8fS8xvmFACcdYsnAeA7g
 sA5cAebGn2yhZIjq+Qt36hgIYwDREe+YdXTkkIW155hpW0YH7SQx6dQIc/6Yu9IjN3dF
 CsGLDcou4717Q5vm6V/efglqyljZ8RdFLUIdRREa3cTp4ESb7seo+vYOYLc9S+Ri2PEZ
 eGQXBDUjRITzuKPTkXIfGUOIjZgIpGy90Ce+9P0cOFDVogjTbbN3+7nJfGlYm/IVWAU7
 +9UA==
X-Gm-Message-State: AOJu0Yzcjw7Sfdbx0+3c4++SzmslYFH73QIUX49VfxWL6yHXOY7F6MeF
 8zChaAx5YGOcIRFRjHFj9Db9EbXzhwi2nfMtjOg=
X-Google-Smtp-Source: AGHT+IHw8MwBsK3s0Ayyxw6uwAD+NqFjqpg/A5zLwEI389PUUBwPkWPCRTiZ9JEoNbuZVbNjCfkAAb9n5bO3CQJWUAo=
X-Received: by 2002:adf:e68a:0:b0:31f:db12:f5db with SMTP id
 r10-20020adfe68a000000b0031fdb12f5dbmr6164571wrm.32.1696085297664; Sat, 30
 Sep 2023 07:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 30 Sep 2023 07:48:06 -0700
Message-ID: <CAADnVQLg+p8uQ4JX16JAj8hMNji+OfManPymisO3c_o=ZseQdA@mail.gmail.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/dwtQswTqK1RqBfq3jC58WRqBc1k>
Subject: Re: [Bpf] Signed modulo operations
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

T24gRnJpLCBTZXAgMjksIDIwMjMgYXQgMjowM+KAr1BNIERhdmUgVGhhbGVyCjxkdGhhbGVyPTQw
bWljcm9zb2Z0LmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6Cj4KPiBQZXJoYXBzIHRleHQgbGlr
ZSB0aGUgcHJvcG9zZWQgc25pcHBldCBxdW90ZWQgaW4gdGhlIGV4Y2hhbmdlIGFib3ZlIHNob3Vs
ZCBiZQo+IGFkZGVkIGFyb3VuZCB0aGUgbmV3IHRleHQgdGhhdCBub3cgYXBwZWFycyBpbiB0aGUg
ZG9jLCBpLmUuIHRoZSBhbWJpZ3VvdXMgdGV4dAo+IGlzIGN1cnJlbnRseToKPiA+IEZvciBzaWdu
ZWQgb3BlcmF0aW9ucyAoYGBCUEZfU0RJVmBgIGFuZCBgYEJQRl9TTU9EYGApLCBmb3IgYGBCUEZf
QUxVYGAsCj4gPiAnaW1tJyBpcyBpbnRlcnByZXRlZCBhcyBhIDMyLWJpdCBzaWduZWQgdmFsdWUu
IEZvciBgYEJQRl9BTFU2NGBgLCAnaW1tJwo+ID4gaXMgZmlyc3QgOnRlcm06YHNpZ24gZXh0ZW5k
ZWQ8U2lnbiBFeHRlbmQ+YCBmcm9tIDMyIHRvIDY0IGJpdHMsIGFuZCB0aGVuCj4gPiBpbnRlcnBy
ZXRlZCBhcyBhIDY0LWJpdCBzaWduZWQgdmFsdWUuCgpUaGF0J3Mgd2hhdCB3ZSBoYXZlIGluIHRo
ZSBkb2MgYW5kIGl0J3MgYSBjb3JyZWN0IGRlc2NyaXB0aW9uLgpXaGljaCBwYXJ0IGlzIGFtYmln
dW91cz8KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRm
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

