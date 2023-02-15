Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E506F6983BB
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 19:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBOSpo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 13:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBOSpo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 13:45:44 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5543E0B5
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:45:14 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id c9-20020a63da09000000b004fb1a5a46e9so7603196pgh.20
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676486681;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcuqa9ozIL0M0hdPl5/4HIL8ejUVi16ooUH7Tmd4odE=;
        b=Cg78H/JeGg15xpU5BaQ6TVLsFlrGP9A/u3wiXNyLmmLS7YVS0+YsBZkXab6tMAELpf
         YEpgHIirSjxkPjWZ+TcWrlSW2NGjMaLBnY9Be1OYsHDgxbmrHINuHAqiAvLLk1dXvb4y
         /ujrPZEHQzqBPa/cGYDhXOiS6fZdGZDfbnxhSbJapof9fZTH+2m6EMzruBpXUfH/o/Ds
         sfdWKGzNJMWsYO9m69n9qSO60FnLBfgTRHho9k3AEf5X4hyevSLQhVurEhjDMlgk0/KY
         QuLNCB3FPeIvkFZRVt5SDjNykyVovO7NmNloa/gqONrVqq+k0EflT7HglAZkHwYkeQ/X
         BObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676486681;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mcuqa9ozIL0M0hdPl5/4HIL8ejUVi16ooUH7Tmd4odE=;
        b=an6U69Iep4k3CpWQ2tOhVxfFbvbFF0AhNcTUPokTihwc9YwoeNQKNK72QY21EPRm5C
         D9FgQC8K3bHYad3jffLCsD+lhTPJalceKET1Tim5MkXIqNlXOXGpiQzIf6cggQtQm/Uf
         bHQCXbYZLKutYgob+qgP7Q1o77BqGQDwFMSEU8GVi+kMt/XQr+tfZQmMv9Z7V7zORrdx
         IfLc3s0ZIe6rmyPw3gLe1NsOt2Ki5Il2mQzTsOQTrkyvjaL4lOKfunOaB9zZ50gSsm4r
         YQ8xPzlLqh8OvNatb7vlg7Uui4nqA1NvfFrdJ3fXEOxhkUU/FMBUIiGZKN7Eow6iLl1q
         PRIg==
X-Gm-Message-State: AO0yUKWtr0JMolNB0IjhYmoSJ6c1vw6gyHAqmppqdXXnzohMGoSK/bhB
        AYen3jc6KnFEdKRiVgKXCA186bY=
X-Google-Smtp-Source: AK7set+wEjbs6k7kEmqOnUge1y2hw2vQlIq8PFBGXMC8XyUCJvPSNpGO/+FCVSj68oY9YvGyFGs4nJI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8f25:0:b0:5a8:d477:25a with SMTP id
 y5-20020aa78f25000000b005a8d477025amr542993pfr.11.1676486680752; Wed, 15 Feb
 2023 10:44:40 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:44:39 -0800
In-Reply-To: <9204de1c-9d98-fe87-77f8-04554210e479@gmail.com>
Mime-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-2-kuifeng@meta.com>
 <Y+xF8k8RMiG0xBDY@google.com> <9204de1c-9d98-fe87-77f8-04554210e479@gmail.com>
Message-ID: <Y+0oF83AqICySV+H@google.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
From:   Stanislav Fomichev <sdf@google.com>
To:     Kui-Feng Lee <sinquersw@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDIvMTUsIEt1aS1GZW5nIExlZSB3cm90ZToNCj4gVGhhbmsgeW91IGZvciB0aGUgZmVlZGJh
Y2suDQoNCg0KPiBPbiAyLzE0LzIzIDE4OjM5LCBTdGFuaXNsYXYgRm9taWNoZXYgd3JvdGU6DQo+
ID4gT24gMDIvMTQsIEt1aS1GZW5nIExlZSB3cm90ZToNCj4gPiA+IEJQRiBzdHJ1Y3Rfb3BzIG1h
cHMgYXJlIGVtcGxveWVkIGRpcmVjdGx5IHRvIHJlZ2lzdGVyIFRDUCBDb25nZXN0aW9uDQo+ID4g
PiBDb250cm9sIGFsZ29yaXRobXMuIFVubGlrZSBvdGhlciBCUEYgcHJvZ3JhbXMgdGhhdCB0ZXJt
aW5hdGUgd2hlbg0KPiA+ID4gdGhlaXIgbGlua3MgZ29uZSwgdGhlIHN0cnVjdF9vcHMgcHJvZ3Jh
bSByZWR1Y2VzIGl0cyByZWZjb3VudCBzb2xlbHkNCj4gPiA+IHVwb24gZGVhdGggb2YgaXRzIEZE
LiBUaGUgbGluayBvZiBhIEJQRiBzdHJ1Y3Rfb3BzIG1hcCBwcm92aWRlcyBhDQo+ID4gPiB1bmlm
b3JtIGV4cGVyaWVuY2UgYWtpbiB0byBvdGhlciB0eXBlcyBvZiBCUEYgcHJvZ3JhbXMu77+9IEEg
VENQDQo+ID4gPiBDb25nZXN0aW9uIENvbnRyb2wgYWxnb3JpdGhtIHdpbGwgYmUgdW5yZWdpc3Rl
cmVkIHVwb24gZGVzdHJveWluZyB0aGUNCj4gPiA+IEZEIGluIHRoZSBmb2xsb3dpbmcgcGF0Y2hl
cy4NCj4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQG1ldGEu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiDvv70gaW5jbHVkZS9saW51eC9icGYuaO+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSB877+9IDYgKysrLQ0KPiA+ID4g77+9IGluY2x1ZGUvdWFw
aS9saW51eC9icGYuaO+/ve+/ve+/ve+/ve+/ve+/vSB877+9IDQgKysrDQo+ID4gPiDvv70ga2Vy
bmVsL2JwZi9icGZfc3RydWN0X29wcy5j77+977+977+9IHwgNjYgIA0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiDvv70ga2VybmVsL2JwZi9zeXNjYWxsLmPvv73v
v73vv73vv73vv73vv73vv73vv73vv73vv70gfCAyOSArKysrKysrKysrLS0tLS0NCj4gPiA+IO+/
vSB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggfO+/vSA0ICsrKw0KPiA+ID4g77+9IHRv
b2xzL2xpYi9icGYvYnBmLmPvv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv70gfO+/vSAy
ICsrDQo+ID4gPiDvv70gdG9vbHMvbGliL2JwZi9saWJicGYuY++/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/vSB877+9IDEgKw0KPiA+ID4g77+9IDcgZmlsZXMgY2hhbmdlZCwgMTAyIGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9icGYuaCBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4gPiA+IGluZGV4IDhiNWQwYjRjNGFkYS4u
MTM2ODM1ODRiMDcxIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+ID4gQEAgLTEzOTEsNyArMTM5MSwxMSBA
QCBzdHJ1Y3QgYnBmX2xpbmsgew0KPiA+ID4g77+977+977+977+977+9IHUzMiBpZDsNCj4gPiA+
IO+/ve+/ve+/ve+/ve+/vSBlbnVtIGJwZl9saW5rX3R5cGUgdHlwZTsNCj4gPiA+IO+/ve+/ve+/
ve+/ve+/vSBjb25zdCBzdHJ1Y3QgYnBmX2xpbmtfb3BzICpvcHM7DQo+ID4gPiAt77+977+977+9
IHN0cnVjdCBicGZfcHJvZyAqcHJvZzsNCj4gPg0KPiA+IFsuLl0NCj4gPg0KPiA+ID4gK++/ve+/
ve+/vSB1bmlvbiB7DQo+ID4gPiAr77+977+977+977+977+977+977+9IHN0cnVjdCBicGZfcHJv
ZyAqcHJvZzsNCj4gPiA+ICvvv73vv73vv73vv73vv73vv73vv70gLyogQmFja2VkIGJ5IGEgc3Ry
dWN0X29wcyAodHlwZSA9PQ0KPiA+ID4gQlBGX0xJTktfVVBEQVRFX1NUUlVDVF9PUFMpICovDQo+
ID4gPiAr77+977+977+977+977+977+977+9IHN0cnVjdCBicGZfbWFwICptYXA7DQo+ID4gPiAr
77+977+977+9IH07DQo+ID4NCj4gPiBBbnkgcmVhc29uIHlvdSdyZSBub3QgdXNpbmcgdGhlIGFw
cHJvYWNoIHRoYXQgaGFzIGJlZW4gdXNlZCBmb3Igb3RoZXINCj4gPiBsaW5rcyB3aGVyZSB3ZSBj
cmVhdGUgYSB3cmFwcGluZyBzdHJ1Y3R1cmUgKyBjb250YWluZXJfb2Y/DQo+ID4NCj4gPiBzdHJ1
Y3QgYnB0X3N0cnVjdF9vcHNfbGluayB7DQo+ID4g77+977+977+977+9c3RydWN0IGJwZl9saW5r
IGxpbms7DQo+ID4g77+977+977+977+9c3RydWN0IGJwZl9tYXAgKm1hcDsNCj4gPiB9Ow0KPiA+
DQo+IGBtYXBgIGFuZCBgcHJvZ2AgYXJlIG1lYW50IHRvIGJlIHVzZWQgc2VwYXJhdGVseSwgd2hp
bGUgYHVuaW9uYCBpcyAgDQo+IGRlc2lnbmVkDQo+IGZvciB0aGlzIHB1cnBvc2UuDQoNCj4gVGhl
IGBjb250YWluZXJfb2ZgIGFwcHJvYWNoIGFsc28gd29ya3MuIFdoaWxlIGJvdGggYGNvbnRhaW5l
cl9vZmAgYW5kDQo+IGB1bmlvbmAgYXJlIG9mdGVuIHVzZWQsIGlzIHRoZXJlIGFueSBmYWN0b3Ig
dGhhdCBtYWtlcyB0aGUgZm9ybWVyIGEgYmV0dGVyDQo+IGNob2ljZSB0aGFuIHRoZSBsYXR0ZXI/
DQoNCkkgZ3Vlc3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUuIEJlY2F1c2UgeW91IHNlZW0g
dG8gYWRkIHRoYXQNCmNvbnRhaW5lcl9vZiBhcHByb2FjaCBsYXRlciBvbiB3aXRoICdmYWtlJyBs
aW5rcy4gTWF5YmUgeW91IGNhbiBjbGFyaWZ5DQpvbiB0aGUgcGF0Y2ggd2hlcmUgSSBtYWRlIHRo
YXQgY29tbWVudD8NCg0KDQo+ID4gPiDvv73vv73vv73vv73vv70gc3RydWN0IHdvcmtfc3RydWN0
IHdvcms7DQo+ID4gPiDvv70gfTsNCj4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFw
aS9saW51eC9icGYuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiA+ID4gaW5kZXggMTdh
ZmQyYjM1ZWU1Li4xZTZjZGQwZjM1NWQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgvYnBmLmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiA+ID4g
QEAgLTEwMzMsNiArMTAzMyw3IEBAIGVudW0gYnBmX2F0dGFjaF90eXBlIHsNCj4gPiA+IO+/ve+/
ve+/ve+/ve+/vSBCUEZfUEVSRl9FVkVOVCwNCj4gPiA+IO+/ve+/ve+/ve+/ve+/vSBCUEZfVFJB
Q0VfS1BST0JFX01VTFRJLA0KPiA+ID4g77+977+977+977+977+9IEJQRl9MU01fQ0dST1VQLA0K
PiA+ID4gK++/ve+/ve+/vSBCUEZfU1RSVUNUX09QU19NQVAsDQo+ID4gPiDvv73vv73vv73vv73v
v70gX19NQVhfQlBGX0FUVEFDSF9UWVBFDQo+ID4gPiDvv70gfTsNCj4gPg0KPiA+ID4gQEAgLTYz
NTQsNiArNjM1NSw5IEBAIHN0cnVjdCBicGZfbGlua19pbmZvIHsNCj4gPiA+IO+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/vSBzdHJ1Y3Qgew0KPiA+ID4g77+977+977+977+977+977+977+977+9
77+977+977+977+977+9IF9fdTMyIGlmaW5kZXg7DQo+ID4gPiDvv73vv73vv73vv73vv73vv73v
v73vv73vv70gfSB4ZHA7DQo+ID4gPiAr77+977+977+977+977+977+977+9IHN0cnVjdCB7DQo+
ID4gPiAr77+977+977+977+977+977+977+977+977+977+977+9IF9fdTMyIG1hcF9pZDsNCj4g
PiA+ICvvv73vv73vv73vv73vv73vv73vv70gfSBzdHJ1Y3Rfb3BzX21hcDsNCj4gPiA+IO+/ve+/
ve+/ve+/ve+/vSB9Ow0KPiA+ID4g77+9IH0gX19hdHRyaWJ1dGVfXygoYWxpZ25lZCg4KSkpOw0K
PiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9icGZfc3RydWN0X29wcy5jIGIva2Vy
bmVsL2JwZi9icGZfc3RydWN0X29wcy5jDQo+ID4gPiBpbmRleCBlY2U5ODcwY2FiNjguLjYyMWM4
ZTI0NDgxYSAxMDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5lbC9icGYvYnBmX3N0cnVjdF9vcHMuYw0K
PiA+ID4gKysrIGIva2VybmVsL2JwZi9icGZfc3RydWN0X29wcy5jDQo+ID4gPiBAQCAtNjk4LDMg
KzY5OCw2OSBAQCB2b2lkIGJwZl9zdHJ1Y3Rfb3BzX3B1dChjb25zdCB2b2lkICprZGF0YSkNCj4g
PiA+IO+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBjYWxsX3JjdSgmc3RfbWFwLT5yY3UsIGJw
Zl9zdHJ1Y3Rfb3BzX3B1dF9yY3UpOw0KPiA+ID4g77+977+977+977+977+9IH0NCj4gPiA+IO+/
vSB9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHZvaWQgYnBmX3N0cnVjdF9vcHNfbWFwX2xpbmtf
cmVsZWFzZShzdHJ1Y3QgYnBmX2xpbmsgKmxpbmspDQo+ID4gPiArew0KPiA+ID4gK++/ve+/ve+/
vSBpZiAobGluay0+bWFwKSB7DQo+ID4gPiAr77+977+977+977+977+977+977+9IGJwZl9tYXBf
cHV0KGxpbmstPm1hcCk7DQo+ID4gPiAr77+977+977+977+977+977+977+9IGxpbmstPm1hcCA9
IE5VTEw7DQo+ID4gPiAr77+977+977+9IH0NCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3Rh
dGljIHZvaWQgYnBmX3N0cnVjdF9vcHNfbWFwX2xpbmtfZGVhbGxvYyhzdHJ1Y3QgYnBmX2xpbmsg
KmxpbmspDQo+ID4gPiArew0KPiA+ID4gK++/ve+/ve+/vSBrZnJlZShsaW5rKTsNCj4gPiA+ICt9
DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHZvaWQgYnBmX3N0cnVjdF9vcHNfbWFwX2xpbmtfc2hv
d19mZGluZm8oY29uc3Qgc3RydWN0DQo+ID4gPiBicGZfbGluayAqbGluaywNCj4gPiA+ICvvv73v
v73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73v
v73vv73vv70gc3RydWN0IHNlcV9maWxlICpzZXEpDQo+ID4gPiArew0KPiA+ID4gK++/ve+/ve+/
vSBzZXFfcHJpbnRmKHNlcSwgIm1hcF9pZDpcdCVkXG4iLA0KPiA+ID4gK++/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/vSBsaW5rLT5tYXAtPmlkKTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAr
c3RhdGljIGludCBicGZfc3RydWN0X29wc19tYXBfbGlua19maWxsX2xpbmtfaW5mbyhjb25zdCBz
dHJ1Y3QNCj4gPiA+IGJwZl9saW5rICpsaW5rLA0KPiA+ID4gK++/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
vSBzdHJ1Y3QgYnBmX2xpbmtfaW5mbyAqaW5mbykNCj4gPiA+ICt7DQo+ID4gPiAr77+977+977+9
IGluZm8tPnN0cnVjdF9vcHNfbWFwLm1hcF9pZCA9IGxpbmstPm1hcC0+aWQ7DQo+ID4gPiAr77+9
77+977+9IHJldHVybiAwOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGJwZl9saW5rX29wcyBicGZfc3RydWN0X29wc19tYXBfbG9wcyA9IHsNCj4gPiA+ICvv
v73vv73vv70gLnJlbGVhc2UgPSBicGZfc3RydWN0X29wc19tYXBfbGlua19yZWxlYXNlLA0KPiA+
ID4gK++/ve+/ve+/vSAuZGVhbGxvYyA9IGJwZl9zdHJ1Y3Rfb3BzX21hcF9saW5rX2RlYWxsb2Ms
DQo+ID4gPiAr77+977+977+9IC5zaG93X2ZkaW5mbyA9IGJwZl9zdHJ1Y3Rfb3BzX21hcF9saW5r
X3Nob3dfZmRpbmZvLA0KPiA+ID4gK++/ve+/ve+/vSAuZmlsbF9saW5rX2luZm8gPSBicGZfc3Ry
dWN0X29wc19tYXBfbGlua19maWxsX2xpbmtfaW5mbywNCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+
ID4gK2ludCBsaW5rX2NyZWF0ZV9zdHJ1Y3Rfb3BzX21hcCh1bmlvbiBicGZfYXR0ciAqYXR0ciwg
YnBmcHRyX3QgdWF0dHIpDQo+ID4gPiArew0KPiA+DQo+ID4gWy4uXQ0KPiA+DQo+ID4gPiAr77+9
77+977+9IHN0cnVjdCBicGZfbGlua19wcmltZXIgbGlua19wcmltZXI7DQo+ID4gPiAr77+977+9
77+9IHN0cnVjdCBicGZfbWFwICptYXA7DQo+ID4gPiAr77+977+977+9IHN0cnVjdCBicGZfbGlu
ayAqbGluayA9IE5VTEw7DQo+ID4NCj4gPiBBcmUgd2Ugc3RpbGwgdHJ5aW5nIHRvIGtlZXAgcmV2
ZXJzZSBjaHJpc3RtYXMgdHJlZXM/DQoNCj4gWWVzLCBJIHdpbGwgcmVvcmRlciB0aGVtLg0KDQoN
Cj4gPg0KPiA+ID4gK++/ve+/ve+/vSBpbnQgZXJyOw0KPiA+ID4gKw0KPiA+ID4gK++/ve+/ve+/
vSBtYXAgPSBicGZfbWFwX2dldChhdHRyLT5saW5rX2NyZWF0ZS5wcm9nX2ZkKTsNCj4gPg0KPiA+
IGJwZl9tYXBfZ2V0IGNhbiBmYWlsIGhlcmU/DQoNCg0KPiBXZSBoYXZlIGFscmVhZHkgdmVyaWZp
ZWQgdGhlIGBhdHRhY2hfdHlwZWAgb2YgdGhlIGxpbmsgYmVmb3JlIGNhbGxpbmcgdGhpcw0KPiBm
dW5jdGlvbiwgc28gYW4gZXJyb3Igc2hvdWxkIG5vdCBvY2N1ci4gSWYgaXQgZG9lcyBoYXBwZW4s
IGhvd2V2ZXIsDQo+IHNvbWV0aGluZyB0cnVseSB1bnVzdWFsIG11c3QgYmUgaGFwcGVuaW5nLiBU
byBlbnN1cmUgbWF4aW11bSBwcm90ZWN0aW9uICANCj4gYW5kDQo+IGF2b2lkIHRoaXMgaXNzdWUg
aW4gdGhlIGZ1dHVyZSwgSSB3aWxsIGFkZCBhIGNoZWNrIGhlcmUgYXMgd2VsbC4NCg0KSWYgd2Un
dmUgYWxyZWFkeSBjaGVja2VkLCBpdCdzIGZpbmUgbm90IHRvIGNoZWNrIGhlcmUuIEkgaGF2ZW4n
dCBsb29rZWQNCmF0IHRoZSByZWFsIHBhdGgsIHRoYW5rcyBmb3IgY2xhcmlmeWluZy4NCg0KDQo+
ID4NCj4gPiA+ICvvv73vv73vv70gaWYgKG1hcC0+bWFwX3R5cGUgIT0gQlBGX01BUF9UWVBFX1NU
UlVDVF9PUFMpDQo+ID4gPiAr77+977+977+977+977+977+977+9IHJldHVybiAtRUlOVkFMOw0K
PiA+ID4gKw0KPiA+ID4gK++/ve+/ve+/vSBsaW5rID0ga3phbGxvYyhzaXplb2YoKmxpbmspLCBH
RlBfVVNFUik7DQo+ID4gPiAr77+977+977+9IGlmICghbGluaykgew0KPiA+ID4gK++/ve+/ve+/
ve+/ve+/ve+/ve+/vSBlcnIgPSAtRU5PTUVNOw0KPiA+ID4gK++/ve+/ve+/ve+/ve+/ve+/ve+/
vSBnb3RvIGVycl9vdXQ7DQo+ID4gPiAr77+977+977+9IH0NCj4gPiA+ICvvv73vv73vv70gYnBm
X2xpbmtfaW5pdChsaW5rLCBCUEZfTElOS19UWVBFX1NUUlVDVF9PUFMsDQo+ID4gPiAmYnBmX3N0
cnVjdF9vcHNfbWFwX2xvcHMsIE5VTEwpOw0KPiA+ID4gK++/ve+/ve+/vSBsaW5rLT5tYXAgPSBt
YXA7DQo+ID4gPiArDQo+ID4gPiAr77+977+977+9IGVyciA9IGJwZl9saW5rX3ByaW1lKGxpbmss
ICZsaW5rX3ByaW1lcik7DQo+ID4gPiAr77+977+977+9IGlmIChlcnIpDQo+ID4gPiAr77+977+9
77+977+977+977+977+9IGdvdG8gZXJyX291dDsNCj4gPiA+ICsNCj4gPiA+ICvvv73vv73vv70g
cmV0dXJuIGJwZl9saW5rX3NldHRsZSgmbGlua19wcmltZXIpOw0KPiA+ID4gKw0KPiA+ID4gK2Vy
cl9vdXQ6DQo+ID4gPiAr77+977+977+9IGJwZl9tYXBfcHV0KG1hcCk7DQo+ID4gPiAr77+977+9
77+9IGtmcmVlKGxpbmspOw0KPiA+ID4gK++/ve+/ve+/vSByZXR1cm4gZXJyOw0KPiA+ID4gK30N
Cj4gPiA+ICsNCj4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL3N5c2NhbGwuYyBiL2tlcm5l
bC9icGYvc3lzY2FsbC5jDQo+ID4gPiBpbmRleCBjZGE4ZDAwZjM3NjIuLjU0ZTE3MmQ4ZjVkMSAx
MDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5lbC9icGYvc3lzY2FsbC5jDQo+ID4gPiArKysgYi9rZXJu
ZWwvYnBmL3N5c2NhbGwuYw0KPiA+ID4gQEAgLTI3MzgsNyArMjczOCw5IEBAIHN0YXRpYyB2b2lk
IGJwZl9saW5rX2ZyZWUoc3RydWN0IGJwZl9saW5rICpsaW5rKQ0KPiA+ID4g77+977+977+977+9
77+9IGlmIChsaW5rLT5wcm9nKSB7DQo+ID4gPiDvv73vv73vv73vv73vv73vv73vv73vv73vv70g
LyogZGV0YWNoIEJQRiBwcm9ncmFtLCBjbGVhbiB1cCB1c2VkIHJlc291cmNlcyAqLw0KPiA+ID4g
77+977+977+977+977+977+977+977+977+9IGxpbmstPm9wcy0+cmVsZWFzZShsaW5rKTsNCj4g
PiA+IC3vv73vv73vv73vv73vv73vv73vv70gYnBmX3Byb2dfcHV0KGxpbmstPnByb2cpOw0KPiA+
ID4gK++/ve+/ve+/ve+/ve+/ve+/ve+/vSBpZiAobGluay0+dHlwZSAhPSBCUEZfTElOS19UWVBF
X1NUUlVDVF9PUFMpDQo+ID4gPiAr77+977+977+977+977+977+977+977+977+977+977+9IGJw
Zl9wcm9nX3B1dChsaW5rLT5wcm9nKTsNCj4gPiA+ICvvv73vv73vv73vv73vv73vv73vv70gLyog
VGhlIHN0cnVjdF9vcHMgbGlua3MgY2xlYW4gdXAgbWFwIGJ5IHRoZW0tc2VsdmVzLiAqLw0KPiA+
DQo+ID4gV2h5IG5vdCBtb3JlIGdlbmVyaWM6DQo+ID4NCj4gPiBpZiAobGluay0+cHJvZykNCj4g
PiDvv73vv73vv73vv71icGZfcHJvZ19wdXQobGluay0+cHJvZyk7DQo+ID4NCj4gPiA/DQo+IFRo
ZSBgcHJvZ2AgYW5kIGBtYXBgIGZ1bmN0aW9ucyBhcmUgbm93IG9jY3VweWluZyB0aGUgc2FtZSBz
cGFjZS4gSSdtICANCj4gYWZyYWlkDQo+IHRoaXMgY2hlY2sgd29uJ3Qgd29yay4NCg0KSG1tLCBn
b29kIHBvaW50LiBJbiB0aGlzIGNhc2U6IHdoeSBub3QgaGF2ZSBzZXBhcmF0ZSBwcm9nL21hcCBw
b2ludGVycw0KaW5zdGVhZCBvZiBhIHVuaW9uPyBBcmUgd2UgMTAwJSBzdXJlIHN0cnVjdF9vcHMg
aXMgdW5pcXVlIGVub3VnaA0KYW5kIHRoZXJlIHdvbid0IGV2ZXIgYmUgYW5vdGhlciBtYXAtYmFz
ZWQgbGlua3M/DQoNCj4gPg0KPiA+DQo+ID4gPiDvv73vv73vv73vv73vv70gfQ0KPiA+ID4g77+9
77+977+977+977+9IC8qIGZyZWUgYnBmX2xpbmsgYW5kIGl0cyBjb250YWluaW5nIG1lbW9yeSAq
Lw0KPiA+ID4g77+977+977+977+977+9IGxpbmstPm9wcy0+ZGVhbGxvYyhsaW5rKTsNCj4gPiA+
IEBAIC0yNzk0LDE2ICsyNzk2LDE5IEBAIHN0YXRpYyB2b2lkIGJwZl9saW5rX3Nob3dfZmRpbmZv
KHN0cnVjdA0KPiA+ID4gc2VxX2ZpbGUgKm0sIHN0cnVjdCBmaWxlICpmaWxwKQ0KPiA+ID4g77+9
77+977+977+977+9IGNvbnN0IHN0cnVjdCBicGZfcHJvZyAqcHJvZyA9IGxpbmstPnByb2c7DQo+
ID4gPiDvv73vv73vv73vv73vv70gY2hhciBwcm9nX3RhZ1tzaXplb2YocHJvZy0+dGFnKSAqIDIg
KyAxXSA9IHsgfTsNCj4gPg0KPiA+ID4gLe+/ve+/ve+/vSBiaW4yaGV4KHByb2dfdGFnLCBwcm9n
LT50YWcsIHNpemVvZihwcm9nLT50YWcpKTsNCj4gPiA+IO+/ve+/ve+/ve+/ve+/vSBzZXFfcHJp
bnRmKG0sDQo+ID4gPiDvv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv70gImxpbmtf
dHlwZTpcdCVzXG4iDQo+ID4gPiAt77+977+977+977+977+977+977+977+977+977+9ICJsaW5r
X2lkOlx0JXVcbiINCj4gPiA+IC3vv73vv73vv73vv73vv73vv73vv73vv73vv73vv70gInByb2df
dGFnOlx0JXNcbiINCj4gPiA+IC3vv73vv73vv73vv73vv73vv73vv73vv73vv73vv70gInByb2df
aWQ6XHQldVxuIiwNCj4gPiA+ICvvv73vv73vv73vv73vv73vv73vv73vv73vv73vv70gImxpbmtf
aWQ6XHQldVxuIiwNCj4gPiA+IO+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBi
cGZfbGlua190eXBlX3N0cnNbbGluay0+dHlwZV0sDQo+ID4gPiAt77+977+977+977+977+977+9
77+977+977+977+9IGxpbmstPmlkLA0KPiA+ID4gLe+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/vSBwcm9nX3RhZywNCj4gPiA+IC3vv73vv73vv73vv73vv73vv73vv73vv73vv73vv70gcHJv
Zy0+YXV4LT5pZCk7DQo+ID4gPiAr77+977+977+977+977+977+977+977+977+977+9IGxpbmst
PmlkKTsNCj4gPiA+ICvvv73vv73vv70gaWYgKGxpbmstPnR5cGUgIT0gQlBGX0xJTktfVFlQRV9T
VFJVQ1RfT1BTKSB7DQo+ID4gPiAr77+977+977+977+977+977+977+9IGJpbjJoZXgocHJvZ190
YWcsIHByb2ctPnRhZywgc2l6ZW9mKHByb2ctPnRhZykpOw0KPiA+ID4gK++/ve+/ve+/ve+/ve+/
ve+/ve+/vSBzZXFfcHJpbnRmKG0sDQo+ID4gPiAr77+977+977+977+977+977+977+977+977+9
77+977+977+977+977+9ICJwcm9nX3RhZzpcdCVzXG4iDQo+ID4gPiAr77+977+977+977+977+9
77+977+977+977+977+977+977+977+977+9ICJwcm9nX2lkOlx0JXVcbiIsDQo+ID4gPiAr77+9
77+977+977+977+977+977+977+977+977+977+977+977+977+9IHByb2dfdGFnLA0KPiA+ID4g
K++/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBwcm9nLT5hdXgtPmlk
KTsNCj4gPiA+ICvvv73vv73vv70gfQ0KPiA+ID4g77+977+977+977+977+9IGlmIChsaW5rLT5v
cHMtPnNob3dfZmRpbmZvKQ0KPiA+ID4g77+977+977+977+977+977+977+977+977+9IGxpbmst
Pm9wcy0+c2hvd19mZGluZm8obGluaywgbSk7DQo+ID4gPiDvv70gfQ0KPiA+ID4gQEAgLTQyNzgs
NyArNDI4Myw4IEBAIHN0YXRpYyBpbnQgYnBmX2xpbmtfZ2V0X2luZm9fYnlfZmQoc3RydWN0IGZp
bGUNCj4gPiA+ICpmaWxlLA0KPiA+DQo+ID4gPiDvv73vv73vv73vv73vv70gaW5mby50eXBlID0g
bGluay0+dHlwZTsNCj4gPiA+IO+/ve+/ve+/ve+/ve+/vSBpbmZvLmlkID0gbGluay0+aWQ7DQo+
ID4gPiAt77+977+977+9IGluZm8ucHJvZ19pZCA9IGxpbmstPnByb2ctPmF1eC0+aWQ7DQo+ID4g
PiAr77+977+977+9IGlmIChsaW5rLT50eXBlICE9IEJQRl9MSU5LX1RZUEVfU1RSVUNUX09QUykN
Cj4gPiA+ICvvv73vv73vv73vv73vv73vv73vv70gaW5mby5wcm9nX2lkID0gbGluay0+cHJvZy0+
YXV4LT5pZDsNCj4gPg0KPiA+IEhlcmUgYXMgd2VsbDogc2hvdWxkIHdlIGhhdmUgImxpbmstPnR5
cGUgIT0gQlBGX0xJTktfVFlQRV9TVFJVQ1RfT1BTIiB2cw0KPiA+ICJsaW5rLT5wcm9nICE9IE5V
TEwiID8NCg0KDQo+IFNhbWUgYXMgYWJvdmUu77+9IGBtYXBgIGFuZCBgcHJvZ2Agc2hhcmUgdGhl
IHNhbWUgbWVtb3J5IHNwYWNlLg0KDQoNCj4gPg0KPiA+DQo+ID4gPiDvv73vv73vv73vv73vv70g
aWYgKGxpbmstPm9wcy0+ZmlsbF9saW5rX2luZm8pIHsNCj4gPiA+IO+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/vSBlcnIgPSBsaW5rLT5vcHMtPmZpbGxfbGlua19pbmZvKGxpbmssICZpbmZvKTsN
Cj4gPiA+IEBAIC00NTMxLDYgKzQ1MzcsOCBAQCBzdGF0aWMgaW50IGJwZl9tYXBfZG9fYmF0Y2go
Y29uc3QgdW5pb24NCj4gPiA+IGJwZl9hdHRyICphdHRyLA0KPiA+ID4g77+977+977+977+977+9
IHJldHVybiBlcnI7DQo+ID4gPiDvv70gfQ0KPiA+DQo+ID4gPiArZXh0ZXJuIGludCBsaW5rX2Ny
ZWF0ZV9zdHJ1Y3Rfb3BzX21hcCh1bmlvbiBicGZfYXR0ciAqYXR0ciwNCj4gPiA+IGJwZnB0cl90
IHVhdHRyKTsNCj4gPiA+ICsNCj4gPiA+IO+/vSAjZGVmaW5lIEJQRl9MSU5LX0NSRUFURV9MQVNU
X0ZJRUxEIGxpbmtfY3JlYXRlLmtwcm9iZV9tdWx0aS5jb29raWVzDQo+ID4gPiDvv70gc3RhdGlj
IGludCBsaW5rX2NyZWF0ZSh1bmlvbiBicGZfYXR0ciAqYXR0ciwgYnBmcHRyX3QgdWF0dHIpDQo+
ID4gPiDvv70gew0KPiA+ID4gQEAgLTQ1NDEsNiArNDU0OSw5IEBAIHN0YXRpYyBpbnQgbGlua19j
cmVhdGUodW5pb24gYnBmX2F0dHIgKmF0dHIsDQo+ID4gPiBicGZwdHJfdCB1YXR0cikNCj4gPiA+
IO+/ve+/ve+/ve+/ve+/vSBpZiAoQ0hFQ0tfQVRUUihCUEZfTElOS19DUkVBVEUpKQ0KPiA+ID4g
77+977+977+977+977+977+977+977+977+9IHJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gPiAr
77+977+977+9IGlmIChhdHRyLT5saW5rX2NyZWF0ZS5hdHRhY2hfdHlwZSA9PSBCUEZfU1RSVUNU
X09QU19NQVApDQo+ID4gPiAr77+977+977+977+977+977+977+9IHJldHVybiBsaW5rX2NyZWF0
ZV9zdHJ1Y3Rfb3BzX21hcChhdHRyLCB1YXR0cik7DQo+ID4gPiArDQo+ID4gPiDvv73vv73vv73v
v73vv70gcHJvZyA9IGJwZl9wcm9nX2dldChhdHRyLT5saW5rX2NyZWF0ZS5wcm9nX2ZkKTsNCj4g
PiA+IO+/ve+/ve+/ve+/ve+/vSBpZiAoSVNfRVJSKHByb2cpKQ0KPiA+ID4g77+977+977+977+9
77+977+977+977+977+9IHJldHVybiBQVFJfRVJSKHByb2cpOw0KPiA+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiA+ID4gYi90b29scy9pbmNsdWRlL3Vh
cGkvbGludXgvYnBmLmgNCj4gPiA+IGluZGV4IDE3YWZkMmIzNWVlNS4uMWU2Y2RkMGYzNTVkIDEw
MDY0NA0KPiA+ID4gLS0tIGEvdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oDQo+ID4gPiAr
KysgYi90b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiA+IEBAIC0xMDMzLDYgKzEw
MzMsNyBAQCBlbnVtIGJwZl9hdHRhY2hfdHlwZSB7DQo+ID4gPiDvv73vv73vv73vv73vv70gQlBG
X1BFUkZfRVZFTlQsDQo+ID4gPiDvv73vv73vv73vv73vv70gQlBGX1RSQUNFX0tQUk9CRV9NVUxU
SSwNCj4gPiA+IO+/ve+/ve+/ve+/ve+/vSBCUEZfTFNNX0NHUk9VUCwNCj4gPiA+ICvvv73vv73v
v70gQlBGX1NUUlVDVF9PUFNfTUFQLA0KPiA+ID4g77+977+977+977+977+9IF9fTUFYX0JQRl9B
VFRBQ0hfVFlQRQ0KPiA+ID4g77+9IH07DQo+ID4NCj4gPiA+IEBAIC02MzU0LDYgKzYzNTUsOSBA
QCBzdHJ1Y3QgYnBmX2xpbmtfaW5mbyB7DQo+ID4gPiDvv73vv73vv73vv73vv73vv73vv73vv73v
v70gc3RydWN0IHsNCj4gPiA+IO+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
vSBfX3UzMiBpZmluZGV4Ow0KPiA+ID4g77+977+977+977+977+977+977+977+977+9IH0geGRw
Ow0KPiA+ID4gK++/ve+/ve+/ve+/ve+/ve+/ve+/vSBzdHJ1Y3Qgew0KPiA+ID4gK++/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBfX3UzMiBtYXBfaWQ7DQo+ID4gPiAr77+977+977+9
77+977+977+977+9IH0gc3RydWN0X29wc19tYXA7DQo+ID4gPiDvv73vv73vv73vv73vv70gfTsN
Cj4gPiA+IO+/vSB9IF9fYXR0cmlidXRlX18oKGFsaWduZWQoOCkpKTsNCj4gPg0KPiA+ID4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnBmLmMgYi90b29scy9saWIvYnBmL2JwZi5jDQo+ID4g
PiBpbmRleCA5YWZmOThmNDJhM2QuLmU0NGQ0OWYxN2M4NiAxMDA2NDQNCj4gPiA+IC0tLSBhL3Rv
b2xzL2xpYi9icGYvYnBmLmMNCj4gPiA+ICsrKyBiL3Rvb2xzL2xpYi9icGYvYnBmLmMNCj4gPiA+
IEBAIC03MzEsNiArNzMxLDggQEAgaW50IGJwZl9saW5rX2NyZWF0ZShpbnQgcHJvZ19mZCwgaW50
IHRhcmdldF9mZCwNCj4gPiA+IO+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBpZiAoIU9QVFNf
WkVST0VEKG9wdHMsIHRyYWNpbmcpKQ0KPiA+ID4g77+977+977+977+977+977+977+977+977+9
77+977+977+977+9IHJldHVybiBsaWJicGZfZXJyKC1FSU5WQUwpOw0KPiA+ID4g77+977+977+9
77+977+977+977+977+977+9IGJyZWFrOw0KPiA+ID4gK++/ve+/ve+/vSBjYXNlIEJQRl9TVFJV
Q1RfT1BTX01BUDoNCj4gPiA+ICvvv73vv73vv73vv73vv73vv73vv70gYnJlYWs7DQo+ID4gPiDv
v73vv73vv73vv73vv70gZGVmYXVsdDoNCj4gPiA+IO+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
vSBpZiAoIU9QVFNfWkVST0VEKG9wdHMsIGZsYWdzKSkNCj4gPiA+IO+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSByZXR1cm4gbGliYnBmX2VycigtRUlOVkFMKTsNCj4gPiA+
IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2xpYmJwZi5jIGIvdG9vbHMvbGliL2JwZi9saWJi
cGYuYw0KPiA+ID4gaW5kZXggMzVhNjk4ZWI4MjVkLi43NWVkOTViN2U0NTUgMTAwNjQ0DQo+ID4g
PiAtLS0gYS90b29scy9saWIvYnBmL2xpYmJwZi5jDQo+ID4gPiArKysgYi90b29scy9saWIvYnBm
L2xpYmJwZi5jDQo+ID4gPiBAQCAtMTE1LDYgKzExNSw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICog
Y29uc3QgYXR0YWNoX3R5cGVfbmFtZVtdID0gew0KPiA+ID4g77+977+977+977+977+9IFtCUEZf
U0tfUkVVU0VQT1JUX1NFTEVDVF9PUl9NSUdSQVRFXe+/ve+/ve+/vSA9DQo+ID4gPiAic2tfcmV1
c2Vwb3J0X3NlbGVjdF9vcl9taWdyYXRlIiwNCj4gPiA+IO+/ve+/ve+/ve+/ve+/vSBbQlBGX1BF
UkZfRVZFTlRd77+977+977+977+977+977+977+9ID0gInBlcmZfZXZlbnQiLA0KPiA+ID4g77+9
77+977+977+977+9IFtCUEZfVFJBQ0VfS1BST0JFX01VTFRJXe+/ve+/ve+/vSA9ICJ0cmFjZV9r
cHJvYmVfbXVsdGkiLA0KPiA+ID4gK++/ve+/ve+/vSBbQlBGX1NUUlVDVF9PUFNfTUFQXe+/ve+/
ve+/ve+/ve+/ve+/ve+/vSA9ICJzdHJ1Y3Rfb3BzX21hcCIsDQo+ID4gPiDvv70gfTsNCj4gPg0K
PiA+ID4g77+9IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbGlua190eXBlX25hbWVbXSA9IHsN
Cj4gPiA+IC0tDQo+ID4gPiAyLjMwLjINCj4gPg0K
