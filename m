Return-Path: <bpf+bounces-4437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D51874B4C6
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05828281763
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48510944;
	Fri,  7 Jul 2023 16:01:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100910795
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:00:59 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C2E1BC3
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:00:58 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9AD4BC151710
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688745658; bh=nbXBR3W//0ebf0YJEcRlDVS/dkQOaH21YA69JIQ7Qvo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=RRoXU5deDKDFmrzNLja0BAHN3fMZ3vEn5NGZQ7wzE+uMjTaA0ceLZcq2VUhzg28AS
	 iD8KIJI7a7wskqiScKFflgt6Z8k6Bczg3I3xPOvkqlCPYrEooUFN3TwRDRAGQe+Fl+
	 4FCMHD68cSsXV0Gf1Wj3eLK2CxhZA97EeJ+CYk8g=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul  7 09:00:58 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 718F5C15155B;
	Fri,  7 Jul 2023 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688745658; bh=nbXBR3W//0ebf0YJEcRlDVS/dkQOaH21YA69JIQ7Qvo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=RRoXU5deDKDFmrzNLja0BAHN3fMZ3vEn5NGZQ7wzE+uMjTaA0ceLZcq2VUhzg28AS
	 iD8KIJI7a7wskqiScKFflgt6Z8k6Bczg3I3xPOvkqlCPYrEooUFN3TwRDRAGQe+Fl+
	 4FCMHD68cSsXV0Gf1Wj3eLK2CxhZA97EeJ+CYk8g=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AA536C15155B
 for <bpf@ietfa.amsl.com>; Fri,  7 Jul 2023 09:00:57 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.098
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bxd-KHZGLjeF for <bpf@ietfa.amsl.com>;
 Fri,  7 Jul 2023 09:00:57 -0700 (PDT)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 266FFC15155A
 for <bpf@ietf.org>; Fri,  7 Jul 2023 09:00:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b63e5f94f1so26072091fa.1
 for <bpf@ietf.org>; Fri, 07 Jul 2023 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688745655; x=1691337655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beSJIkhZ1mrhGoJFwJoIZU5b5WTDvSAWyPHUCduELkE=;
 b=BNKBN19JcLtmyiSFVQSOss/dvveuS9zwPsi16h4cdg81Z+PYvIfWgxxqc2Mz/pePkL
 InD/Ra7fGo13H3FycN+LAsPDGNoPuuqaN7XoohlUk/x5latXdN/dTBktWJLszdClO20l
 F+NddSh3SucyIiQiuClkkgfkrKOUjtw5mr2jHx11+tRw2rmGkXwMdmLphBfaOGAGCDXE
 FKfUqk0jNXiHUlfLuGX9q1y9/TChLvuSTzl2l/2ToWMF9BBFM1iqU8GaKHXllXiWXi8e
 NbNm/mkGp5HagdFkXYpDpFTZhMyx1KUGvopogzfdA0+MtbT4jYkCr8zjuSUB19k/AUlC
 LAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688745655; x=1691337655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beSJIkhZ1mrhGoJFwJoIZU5b5WTDvSAWyPHUCduELkE=;
 b=UR7rLg3MM9LJQUG7KgFbuvM3C5ryih6rzwPcwLqLKwm0tYp7ZsU6DZRFKhJHaUUa3B
 MbhIvpHQj5J2gSPQb3pKK6FsiDgp4baXOZCE0MIwJaw7QgDDwel4xO8PKDGm2HZNpwIl
 ThZh3w7YY94zt9tz+XoqUkV8PiOHoBPXlD9Xv9+XKfzsLWuyetE9eZQ6Q+EOU9hIqY0B
 xKjL8n03SCaO4cf9EiUXGn0CoC1iEpgoTEROY8mIvox6yxPAvO8LW8SddB7Paewvukb5
 UAf7zt0PxtCvEZfy7b1mrTmNcz2kZ5MnZZQS23859e/ngfBvP0VWAnyn2glMh0P/HU7f
 UKkQ==
X-Gm-Message-State: ABy/qLaOgms9fcC4s7lU6qPKOECj/OgcznKL3nybBV5KUZXTXNEgbfQP
 BJww+0m4Zz4NQCQVLwOTJFWfe7oZPMhXEzTr2+FkJg51
X-Google-Smtp-Source: APBJJlF0zchngRB/hnloZAdmK7buggvDVCDMxftne2PQeYQVO/8Fy1uY9/e6MvuChNVtbLXLUg/OAcI3he9kdD7f380=
X-Received: by 2002:a2e:7819:0:b0:2b6:c3f9:b86b with SMTP id
 t25-20020a2e7819000000b002b6c3f9b86bmr2141743ljc.15.1688745654554; Fri, 07
 Jul 2023 09:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com>
 <PH7PR21MB3878DEA7280C274A8A18D082A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878DEA7280C274A8A18D082A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Jul 2023 09:00:43 -0700
Message-ID: <CAADnVQ+ogOVdwZSX4315hHe8bxP-yoYEacNPCP6CTHqn=Xp-uQ@mail.gmail.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/SUb1Jfl3zacKnStr9nhmM7VoF8c>
Subject: Re: [Bpf] Instruction set extension policy
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCA2OjM14oCvUE0gRGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWlj
cm9zb2Z0LmNvbT4gd3JvdGU6Cj4KPiBJIGRvbid0IHNlZSBhbnkgcHJvYmxlbSB3aXRoIGRlZmlu
aW5nIGFuIElBTkEgcmVnaXN0cnkgd2l0aCBtdWx0aXBsZSAia2V5IiBmaWVsZHMKPiAob3Bjb2Rl
K3NyYytpbW0pLiAgQWxsIGV4aXN0aW5nIGluc3RydWN0aW9ucyBjYW4gYmUgZG9uZSBhcyBzdWNo
Lgo+Cj4gQmVsb3cgaXMgc3RyYXdtYW4gdGV4dCB0aGF0IEkgdGhpbmsgZm9sbG93cyBJQU5BJ3Mg
cmVxdWlyZW1lbnRzIG91dGxpbmVkCj4gaW4gUkZDIDgxMjYuLi4KPgo+IC1EYXZlCj4KPiAtLS0g
c25pcCAtLS0KPiBJQU5BIENvbnNpZGVyYXRpb25zCj4gPT09PT09PT09PT09PT09PT09PQo+Cj4g
VGhpcyBkb2N1bWVudCBwcm9wb3NlcyBhIG5ldyBJQU5BIHJlZ2lzdHJ5IGZvciBCUEYgaW5zdHJ1
Y3Rpb25zLCBhcyBmb2xsb3dzOgo+Cj4gKiBOYW1lIG9mIHRoZSByZWdpc3RyeTogQlBGIEluc3Ry
dWN0aW9uIFNldAo+ICogTmFtZSBvZiB0aGUgcmVnaXN0cnkgZ3JvdXA6IHNhbWUgYXMgcmVnaXN0
cnkgbmFtZQo+ICogUmVxdWlyZWQgaW5mb3JtYXRpb24gZm9yIHJlZ2lzdHJhdGlvbnM6IFRoZSB2
YWx1ZXMgdG8gYXBwZWFyIGluIHRoZSBlbnRyeSBmaWVsZHMuCj4gKiBTeW50YXggb2YgcmVnaXN0
cnkgZW50cmllczogRWFjaCBlbnRyeSBoYXMgdGhlIGZvbGxvd2luZyBmaWVsZHM6Cj4gICAqIG9w
Y29kZTogYSAxLWJ5dGUgdmFsdWUgaW4gaGV4IGZvcm1hdCBpbmRpY2F0aW5nIHRoZSB2YWx1ZSBv
ZiB0aGUgb3Bjb2RlIGZpZWxkCj4gICAqIHNyYzogYSA0LWJpdCB2YWx1ZSBpbiBoZXggZm9ybWF0
IGluZGljYXRpbmcgdGhlIHZhbHVlIG9mIHRoZSBzcmMgZmllbGQsIG9yICJhbnkiCj4gICAqIGlt
bTogZWl0aGVyIGEgdmFsdWUgaW4gaGV4IGZvcm1hdCBpbmRpY2F0aW5nIHRoZSB2YWx1ZSBvZiB0
aGUgaW1tIGZpZWxkLCBvciAiYW55Igo+ICAgKiBkZXNjcmlwdGlvbjogZGVzY3JpcHRpb24gb2Yg
d2hhdCB0aGUgaW5zdHJ1Y3Rpb24gZG9lcywgdHlwaWNhbGx5IGluIHBzZXVkb2NvZGUKPiAgICog
cmVmZXJlbmNlOiBhIHJlZmVyZW5jZSB0byB0aGUgZGVmaW5pbmcgc3BlY2lmaWNhdGlvbgo+ICAg
KiBzdGF0dXM6IFBlcm1hbmVudCwgUHJvdmlzaW9uYWwsIG9yIEhpc3RvcmljYWwKPiAqIFJlZ2lz
dHJhdGlvbiBwb2xpY3kgKHNlZSBSRkMgODEyNiBzZWN0aW9uIDQgZm9yIGRldGFpbHMpOgo+ICAg
KiBQZXJtYW5lbnQ6IFN0YW5kYXJkcyBhY3Rpb24KPiAgICogUHJvdmlzaW9uYWw6IFNwZWNpZmlj
YXRpb24gcmVxdWlyZWQKPiAgICogSGlzdG9yaWNhbDogU3BlY2lmaWNhdGlvbiByZXF1aXJlZAo+
ICogSW5pdGlhbCByZWdpc3RyYXRpb25zOiBTZWUgdGhlIEFwcGVuZGl4LiBJbnN0cnVjdGlvbnMg
b3RoZXIgdGhhbiB0aG9zZSBsaXN0ZWQKPiAgIGFzIGRlcHJlY2F0ZWQgYXJlIFBlcm1hbmVudC4g
QW55IGxpc3RlZCBhcyBkZXByZWNhdGVkIGFyZSBIaXN0b3JpY2FsLgoKSSB0aGluayB0aGF0IG1p
Z2h0IHdvcmsuIFdoYXQgaXMgdGhlIG5leHQgc3RlcCB0aGVuPwpXaG8gaXMgZ29pbmcgdG8gZ2Vu
ZXJhdGUgc3VjaCBhIGhleCBkYXRhYmFzZT8KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRm
Lm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

