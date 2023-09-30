Return-Path: <bpf+bounces-11159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2927B41BD
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D356BB20DA8
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5615495;
	Sat, 30 Sep 2023 15:37:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993B946D
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 15:36:59 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C7B3
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 08:36:58 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0F8A9C17CEA7
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696088218; bh=bxdIrJrANwTUbzE5BS1rRbJBabKAIbXtZS5T5XZdHo4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ewFitMjF/Be8qIZblSpaD6/LctcRNh77FWN0Bd3ssyOYrHnWeKphbYqOgeLYtY660
	 V7/pDrLbgLcYwY+C8fXXizgrLd/StPOMU10DAs0sgIJkqyvUbzjHXqrbCptSAMh73p
	 O0A7FnNuLsSW4GUmD+zRMvgcIr6V40UYk4jCUdhs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Sep 30 08:36:58 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D0F4AC13AE5A;
	Sat, 30 Sep 2023 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696088217; bh=bxdIrJrANwTUbzE5BS1rRbJBabKAIbXtZS5T5XZdHo4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=RteUq+Bjtcc19mnBQgSCCq194ZnJmHNiQ0ABQVv90Xhy2QDaoTXa56t9hDbx0A/ip
	 2gPcJfeoH8ENA/o8eo4HdSNwjZ4lFRhL0VQF9u93U5QLgNip9rLXGxFlR4/ueJ2ljd
	 TC7YXdEwIj6oaerCxx6ftCV6QwboG2L5xkrx6YWA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 137A3C1345E5
 for <bpf@ietfa.amsl.com>; Sat, 30 Sep 2023 08:36:56 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.105
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
 with ESMTP id ilKmoynyw-iR for <bpf@ietfa.amsl.com>;
 Sat, 30 Sep 2023 08:36:52 -0700 (PDT)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 49A9CC13AE5A
 for <bpf@ietf.org>; Sat, 30 Sep 2023 08:36:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3226b8de467so13076453f8f.3
 for <bpf@ietf.org>; Sat, 30 Sep 2023 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696088210; x=1696693010; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQV529HwlabxIKy7J/5tNCMJbN7Wd97B8SSJdVQQjg8=;
 b=XDPhdxS6eAkwdCOPDJnt89H4oSNYgU7dzt3mH/yI7YKY5KkL5B/VWV2wg9CEq3eYx9
 q+0oVYdXFND5gXi9MTD3zy7hSORSW6jiPCONnTk0PlN/qq4jgzZ/vbKSEo+TD69hioBb
 ak6UotP5oCswpDrEqC3SafCbuSMkIkdsc6pWtAKu8lHjGusllBgwYc+6r+t/o1MuPwW7
 vDh/WBNvrE8dGNgyoLzc9KfBNOdQsv9OZCP9KPhDKFj4B65Kw647gGLhJbAq0vhR3e6p
 AIoCh59kyRojPdoSbdI6Gj4/iBozGcTrvDRwayB7T1VZxjXDTz21w3hzV71PqD2fxXEa
 tDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696088210; x=1696693010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQV529HwlabxIKy7J/5tNCMJbN7Wd97B8SSJdVQQjg8=;
 b=dnEbF6jzTAny5jg8hIi1KJBjaJHiqCDpS4Z/xUYorq64JC4fJiHOtsBoZvfh76smHG
 i8NDWuGrur4yyP7/RbmjSzKrdLr0G94jUQAP6k2kxPf3q2NWOBjdKRyHb9wc8bo/Et0+
 5TQfMNUKOYZPYf616UxTU56FiRI+pDsq8qEGdMyRw3EZH31T85ovPwHniIfxwAJzLnNw
 y12bhbv+a6UK5DUqoZDTRcIBo/oAHHl8IMcvnNOULspt9fKK1RuR8tc9ikhomKkyDfUU
 oCjaA8bvJxOpous2mjAEZ9vUEAVU1Zz3sdeiT/Kb5Z1UfGuzOYGVm5aIPykGRx3suL+/
 tYAg==
X-Gm-Message-State: AOJu0YwQrY9bNSUSIVofOWr16o9Zhxjuq+9LB2pIwVhG+Pn1MxNo+mcF
 32xtoif/vRtcA2rW5PpcokGTKifPtWkDGm5iGJhJ11CYgQg=
X-Google-Smtp-Source: AGHT+IGNrnRSxK8he5p8yMrAAPyEzQQFoPVuifatRCCYAMEEDVUNd+EOc4H0fA9nMCo7bxMykFJ+d6lTjjgIAgh5CEo=
X-Received: by 2002:a05:6000:10c4:b0:31a:e6c2:770d with SMTP id
 b4-20020a05600010c400b0031ae6c2770dmr5858915wrx.36.1696088210257; Sat, 30 Sep
 2023 08:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169566875696.34978.17222195480011841703@ietfa.amsl.com>
 <PH7PR21MB3878C2BD3D1BBF7EAE077A03A3FCA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878C2BD3D1BBF7EAE077A03A3FCA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 30 Sep 2023 08:36:39 -0700
Message-ID: <CAADnVQK17vHEL-bjxpBhPTx+PAY8m15w-74DTNrj-01wjo8W=Q@mail.gmail.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/TlJGfFc_4VXCc-GoWR8MY2f1U3A>
Subject: Re: [Bpf] New Version Notification for draft-thaler-bpf-isa-02.txt
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMjo1N+KAr1BNIERhdmUgVGhhbGVyCjxkdGhhbGVyPTQw
bWljcm9zb2Z0LmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6Cj4KPiBkcmFmdC10aGFsZXItYnBm
LWlzYS0wMi50eHQgaXMgbm93IHBvc3RlZCBpbiB0aGUgTGludXgga2VybmVsIHJlcG9zaXRvcnk6
Cj4gaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvZHJhZnQtdGhhbGVyLWJwZi1pc2Ev
CgoiSW5pdGlhbCB2YWx1ZXMgZm9yIHRoZSBCUEYgSW5zdHJ1Y3Rpb24gcmVnaXN0cnkgYXJlIGdp
dmVuIGJlbG93LiIKCmhhcyBiYWQgZm9ybWF0dGluZyB0b3dhcmRzIHRoZSBlbmQgb2YgdGhlIHRh
YmxlIGFyb3VuZCAnbG9jaycgb3BzLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3Jn
Cmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

