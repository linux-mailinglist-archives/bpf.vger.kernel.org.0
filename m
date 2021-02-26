Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCAC325B64
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 02:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBZBys (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 20:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZByq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 20:54:46 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869ACC061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 17:54:06 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z13so8094184iox.8
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 17:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jrv+WJMTn9hg/JAaKUSPebynKhwq4XkWo48iV6Nu3hc=;
        b=Z9wD0U+9ZxCfd7hIWXF6G7HOZZ3/QpbMlk9eog3wbXZ+8/wtls0BLUnROKeIBwp4Of
         caqszKlrWMPfFAwuqR2QV97gTIzKzbjd5YsbApPP+S49Pvt8R/BR2WJpwL4WtIVaZgGk
         daRUm/OT0YWAga2KD51snoiQ54PgPClizSMyHjMtRndvwAfIwit4WjuvI2x+aU0OzpZx
         u+XTifwMNOsGeeG81up6YnU2N97JqC7qIPI0CLNme89T9a43pXNYpPxFWOzbDsnl1B8V
         /wfcV+1JUQouS1OS4zrM93bGlPZjeMYTKZfmwErSDMTAapCELrGoWAdyv3uYnzaPfxLO
         ylVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jrv+WJMTn9hg/JAaKUSPebynKhwq4XkWo48iV6Nu3hc=;
        b=ess1vZjvdSdkW6MAOSd9rJcCq15TjUhnSFmukrIAzeklK8QCeTK1Nf5Cd7m7GgyN9M
         CnLT1nSj7xn9fAefVl6D3uto2TyMRClX72p7EP+55oeDELR4fqSVQL+fLz4IVoKR++Yh
         PxJsskHwnd7JYIBIOGTl+pQVsb3Pm6zwOnc2ZUEHrYnimp7gLu6M/xfTFCYh/MIllZ6t
         Uuy4aZ/PwQhVMXdg96yvEilLi0FL9dmmgS/05jTir+ybIxlEXH36r5tJjCichY0iD+Rv
         F4CGVuhesXAb/k41R97ZDuGaUkShLktw8GGKNvpSgSf+k9pxIdVoJSrP1bVHCEc5GLt7
         Et+Q==
X-Gm-Message-State: AOAM532RPYDfMv7zX2MlHR8F/PDUhGuDd3IwTn/loootXWbhlmmQTeqe
        bjyryUbJqDUuSwlzc684V7+xj2ioXQv9Vg==
X-Google-Smtp-Source: ABdhPJyQ7Ho6wr/iRTWlWIYzvRCRIjQMW3A/octjSwW04m25GKRlIumnS04ZgooxwMHjygAbC4fX6A==
X-Received: by 2002:a5d:9252:: with SMTP id e18mr856239iol.146.1614304445960;
        Thu, 25 Feb 2021 17:54:05 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id i8sm3768142ilv.57.2021.02.25.17.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:54:05 -0800 (PST)
Date:   Thu, 25 Feb 2021 17:53:56 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Message-ID: <603854b45b4a7_5c312088a@john-XPS-13-9370.notmuch>
In-Reply-To: <fbd33830-2f16-23a4-0c31-91bb4bd95ee4@fb.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-7-iii@linux.ibm.com>
 <e7957fca-b938-e50d-74f5-ecc40145eb4d@fb.com>
 <6962feb05a62d718e5d430f782012d71d6c73eed.camel@linux.ibm.com>
 <fbd33830-2f16-23a4-0c31-91bb4bd95ee4@fb.com>
Subject: Re: [PATCH v6 bpf-next 6/9] bpf: Add BTF_KIND_FLOAT support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

WW9uZ2hvbmcgU29uZyB3cm90ZToKPiAKPiAKPiBPbiAyLzI1LzIxIDI6NDAg
QU0sIElseWEgTGVvc2hrZXZpY2ggd3JvdGU6Cj4gPiBPbiBXZWQsIDIwMjEt
MDItMjQgYXQgMjM6MTAgLTA4MDAsIFlvbmdob25nIFNvbmcgd3JvdGU6Cj4g
Pj4gT24gMi8yNC8yMSAzOjQ1IFBNLCBJbHlhIExlb3Noa2V2aWNoIHdyb3Rl
Ogo+ID4+PiBPbiB0aGUga2VybmVsIHNpZGUsIGludHJvZHVjZSBhIG5ldyBi
dGZfa2luZF9vcGVyYXRpb25zLiBJdCBpcwo+ID4+PiBzaW1pbGFyIHRvIHRo
YXQgb2YgQlRGX0tJTkRfSU5ULCBob3dldmVyLCBpdCBkb2VzIG5vdCBuZWVk
IHRvCj4gPj4+IGhhbmRsZSBlbmNvZGluZ3MgYW5kIGJpdCBvZmZzZXRzLiBE
byBub3QgaW1wbGVtZW50IHByaW50aW5nLCBzaW5jZQo+ID4+PiB0aGUga2Vy
bmVsIGRvZXMgbm90IGtub3cgaG93IHRvIGZvcm1hdCBmbG9hdGluZy1wb2lu
dCB2YWx1ZXMuCj4gPj4+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IElseWEgTGVv
c2hrZXZpY2ggPGlpaUBsaW51eC5pYm0uY29tPgo+ID4+PiAtLS0KPiA+Pj4g
IMKgIGtlcm5lbC9icGYvYnRmLmMgfCA3OQo+ID4+PiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KPiA+Pj4gIMKg
IDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9idGYu
YyBiL2tlcm5lbC9icGYvYnRmLmMKPiA+Pj4gaW5kZXggMmVmZWI1ZjRiMzQz
Li5jNDA1ZWRjOGU2MTUgMTAwNjQ0Cj4gPj4+IC0tLSBhL2tlcm5lbC9icGYv
YnRmLmMKPiA+Pj4gKysrIGIva2VybmVsL2JwZi9idGYuYwo+ID4gCj4gPiBb
Li4uXQo+ID4gCj4gPj4+IEBAIC0xODQ5LDcgKzE4NTIsNyBAQCBzdGF0aWMg
aW50IGJ0Zl9kZl9jaGVja19rZmxhZ19tZW1iZXIoc3RydWN0Cj4gPj4+IGJ0
Zl92ZXJpZmllcl9lbnYgKmVudiwKPiA+Pj4gIMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gLUVJTlZBTDsKPiA+Pj4gIMKgIH0KPiA+Pj4gICAgCj4gPj4+IC0v
KiBVc2VkIGZvciBwdHIsIGFycmF5IGFuZCBzdHJ1Y3QvdW5pb24gdHlwZSBt
ZW1iZXJzLgo+ID4+PiArLyogVXNlZCBmb3IgcHRyLCBhcnJheSBzdHJ1Y3Qv
dW5pb24gYW5kIGZsb2F0IHR5cGUgbWVtYmVycy4KPiA+Pj4gIMKgwqAgKiBp
bnQsIGVudW0gYW5kIG1vZGlmaWVyIHR5cGVzIGhhdmUgdGhlaXIgc3BlY2lm
aWMgY2FsbGJhY2sKPiA+Pj4gZnVuY3Rpb25zLgo+ID4+PiAgwqDCoCAqLwo+
ID4+PiAgwqAgc3RhdGljIGludCBidGZfZ2VuZXJpY19jaGVja19rZmxhZ19t
ZW1iZXIoc3RydWN0IGJ0Zl92ZXJpZmllcl9lbnYKPiA+Pj4gKmVudiwKPiA+
Pj4gQEAgLTM2NzUsNiArMzY3OCw3NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGJ0Zl9raW5kX29wZXJhdGlvbnMKPiA+Pj4gZGF0YXNlY19vcHMgPSB7Cj4g
Pj4+ICDCoMKgwqDCoMKgwqDCoMKgLnNob3fCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoD0gYnRmX2RhdGFzZWNfc2hvdywKPiA+Pj4g
IMKgIH07Cj4gPj4+ICAgIAo+ID4+PiArc3RhdGljIHMzMiBidGZfZmxvYXRf
Y2hlY2tfbWV0YShzdHJ1Y3QgYnRmX3ZlcmlmaWVyX2VudiAqZW52LAo+ID4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgYnRmX3R5cGUgKnQs
Cj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBtZXRhX2xlZnQpCj4gPj4+
ICt7Cj4gPj4+ICvCoMKgwqDCoMKgwqDCoGlmIChidGZfdHlwZV92bGVuKHQp
KSB7Cj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidGZf
dmVyaWZpZXJfbG9nX3R5cGUoZW52LCB0LCAidmxlbiAhPSAwIik7Cj4gPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZB
TDsKPiA+Pj4gK8KgwqDCoMKgwqDCoMKgfQo+ID4+PiArCj4gPj4+ICvCoMKg
wqDCoMKgwqDCoGlmIChidGZfdHlwZV9rZmxhZyh0KSkgewo+ID4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnRmX3ZlcmlmaWVyX2xvZ190
eXBlKGVudiwgdCwgIkludmFsaWQgYnRmX2luZm8KPiA+Pj4ga2luZF9mbGFn
Iik7Cj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gLUVJTlZBTDsKPiA+Pj4gK8KgwqDCoMKgwqDCoMKgfQo+ID4+PiArCj4g
Pj4+ICvCoMKgwqDCoMKgwqDCoGlmICh0LT5zaXplICE9IDIgJiYgdC0+c2l6
ZSAhPSA0ICYmIHQtPnNpemUgIT0gOCAmJiB0LT5zaXplCj4gPj4+ICE9IDEy
ICYmCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCB0LT5zaXplICE9IDE2
KSB7Cj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidGZf
dmVyaWZpZXJfbG9nX3R5cGUoZW52LCB0LCAiSW52YWxpZCB0eXBlX3NpemUi
KTsKPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAtRUlOVkFMOwo+ID4+PiArwqDCoMKgwqDCoMKgwqB9Cj4gPj4+ICsKPiA+
Pj4gK8KgwqDCoMKgwqDCoMKgYnRmX3ZlcmlmaWVyX2xvZ190eXBlKGVudiwg
dCwgTlVMTCk7Cj4gPj4+ICsKPiA+Pj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJu
IDA7Cj4gPj4+ICt9Cj4gPj4+ICsKPiA+Pj4gK3N0YXRpYyBpbnQgYnRmX2Zs
b2F0X2NoZWNrX21lbWJlcihzdHJ1Y3QgYnRmX3ZlcmlmaWVyX2VudiAqZW52
LAo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgYnRm
X3R5cGUKPiA+Pj4gKnN0cnVjdF90eXBlLAo+ID4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjb25zdCBzdHJ1Y3QgYnRmX21lbWJlciAqbWVtYmVyLAo+ID4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgYnRmX3R5cGUK
PiA+Pj4gKm1lbWJlcl90eXBlKQo+ID4+PiArewo+ID4+PiArwqDCoMKgwqDC
oMKgwqB1NjQgc3RhcnRfb2Zmc2V0X2J5dGVzOwo+ID4+PiArwqDCoMKgwqDC
oMKgwqB1NjQgZW5kX29mZnNldF9ieXRlczsKPiA+Pj4gK8KgwqDCoMKgwqDC
oMKgdTY0IG1pc2FsaWduX2JpdHM7Cj4gPj4+ICvCoMKgwqDCoMKgwqDCoHU2
NCBhbGlnbl9ieXRlczsKPiA+Pj4gK8KgwqDCoMKgwqDCoMKgdTY0IGFsaWdu
X2JpdHM7Cj4gPj4+ICsKPiA+Pj4gK8KgwqDCoMKgwqDCoMKgYWxpZ25fYnl0
ZXMgPSBtaW5fdCh1NjQsIHNpemVvZih2b2lkICopLCBtZW1iZXJfdHlwZS0K
PiA+Pj4+IHNpemUpOwo+ID4+Cj4gPj4gSSBsaXN0ZWQgdGhlIGZvbGxvd2lu
ZyBwb3NzaWJsZSAoc2l6ZSwgYWxpZ24pIHBhaXJzOgo+ID4+ICDCoMKgwqDC
oCBzaXplwqDCoMKgwqAgeDg2XzMyIGFsaWduX2J5dGVzwqDCoCB4ODZfNjQg
YWxpZ24gYnl0ZXMKPiA+PiAgwqDCoMKgwqDCoCAywqDCoMKgwqDCoMKgwqAg
MsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIKPiA+
PiAgwqDCoMKgwqDCoCA0wqDCoMKgwqDCoMKgwqAgNMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDQKPiA+PiAgwqDCoMKgwqDCoCA4
wqDCoMKgwqDCoMKgwqAgNMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDgKPiA+PiAgwqDCoMKgwqDCoCAxMsKgwqDCoMKgwqDCoCA0
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOAo+ID4+
ICDCoMKgwqDCoMKgIDE2wqDCoMKgwqDCoMKgIDTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA4Cj4gPj4KPiA+PiBBIGZldyBvYnNl
cnZhdGlvbnMuCj4gPj4gIMKgwqAgMS4gSSBkb24ndCBrbm93LCBqdXN0IHdh
bnQgdG8gY29uZmlybSwgZm9yIGRvdWJsZSwgdGhlIGFsaWdubWVudAo+ID4+
IGNvdWxkIGJlIDQgKGZvciBhIG1lbWJlcikgb24gMzJiaXQgc3lzdGVtLCBp
cyB0aGF0IHJpZ2h0Pwo+ID4+ICDCoMKgIDIuIGZvciBzaXplIDEyLCBhbGln
bm1lbnQgd2lsbCBiZSA4IGZvciB4ODZfNjQgc3lzdGVtLCB0aGlzIGlzCj4g
Pj4gc3RyYW5nZSwgbm90IHN1cmUgd2hldGhlciBpdCBpcyB0cnVlIG9yIG5v
dC4gT3Igc2l6ZSAxMiBjYW5ub3QgYmUKPiA+PiBvbiB4ODZfNjQgYW5kIHdl
IHNob3VsZCBlcnJvciBvdXQgaWYgc2l6ZW9mKHZvaWQgKikgaXMgOC4KPiA+
IAo+ID4gMSAtIFllcy4KPiA+IAo+ID4gMiAtIE9uIHg4Nl82NCBsb25nIGRv
dWJsZSBpcyAxNiBieXRlcyBhbmQgdGhlIHJlcXVpcmVkIGFsaWdubWVudCBp
cyAxNgo+ID4gYnl0ZXMgdG9vLiBIb3dldmVyLCBvbiBvdGhlciBhcmNoaXRl
Y3R1cmVzIGFsbCB0aGlzIG1pZ2h0IGJlIGRpZmZlcmVudC4KPiA+IEZvciBl
eGFtcGxlLCBmb3IgdXMgbG9uZyBkb3VibGUgaXMgMTYgYnl0ZXMgdG9vLCBi
dXQgdGhlIGFsaWdubWVudCBjYW4KPiA+IGJlIDguIFNvIGNhbiB3ZSBiZSBz
b21ld2hhdCBsYXggaGVyZSBhbmQganVzdCBhbGxvdyBzbWFsbGVyIGFsaWdu
bWVudHMsCj4gPiBpbnN0ZWFkIG9mIHRyeWluZyB0byBmaWd1cmUgb3V0IHdo
YXQgZXhhY3RseSBlYWNoIHN1cHBvcnRlZAo+ID4gYXJjaGl0ZWN0dXJlIGRv
ZXM/Cj4gCj4gTWF5YmUgdGhpcyBpcyBmaW5lLiBJIHRoaW5rLCAiZmxvYXQi
IGlzIGFsc28gdGhlIGZpcnN0IEJURiB0eXBlIHdob3NlCj4gdmFsaWRhdGlv
biBtYXkgaGF2ZSBhIGRlcGVuZGVuY2Ugb24gdW5kZXJseWluZyBhcmNoaXRl
Y3R1cmUuIEZvciAKPiBleGFtcGxlLCBtZW1iZXIgb2Zmc2V0IDQsIHR5cGUg
c2l6ZSA4LCB3aWxsIGJlIG9rYXkgb24geDg2XzMyLAo+IGJ1dCBub3Qgb2th
eSBvbiB4ODRfNjQuIFRoYXQgbWVhbnMgQlRGIGNhbm5vdCBiZSBpbmRlcGVu
ZGVudGx5Cj4gdmFsaWRhdGVkIHdpdGhvdXQgY29uc2lkZXJpbmcgdW5kZXJs
eWluZyBhcmNoaXRlY3R1cmUuCj4gCj4gSSBhbSBub3QgYWdhaW5zdCB0aGlz
IHBhdGNoLiBNYXliZSBmbG9hdCBpcyBzcGVjaWFsLiBNYXliZSBpdCBpcwo+
IG9rYXkgc2luY2UgZmxvYXQgaXMgcmFyZWx5IHVzZWQuIEkgd291bGQgbGlr
ZSB0byBzZWUgb3RoZXIgcGVvcGxlJ3MKPiBvcGluaW9uLgoKSSBjYW4ndCB0
aGluayBvZiBhbnkgc3BlY2lmaWMgaXNzdWUgaGVyZS4gRnJvbSB0aGUgcHJv
Z3JhbS9CVEYgc2lkZQp0aGUgYWN0dWFsIG9mZnNldHMgb2YgYW55IGdpdmVu
IGZpZWxkIGluIGEgc3RydWN0IGFyZSBnb2luZyB0byB2YXJ5CndpbGRseSBk
ZXBlbmRpbmcgb24gYXJjaCBhbmQgY29uZmlndXJhdGlvbiBhbnl3YXlzLgoK
SSBhc3N1bWUgaWYgYSBCUEYgcHJvZ3JhbSByZWFsbHkgbmVlZHMgdGhlIHNp
emUgdGhlbiAKX19idWlsdGluX3ByZXNlcnZlX2ZpZWxkX2luZm8odmFyLCBC
UEZfRklFTERfQllURV9TSVpFKSB3aWxsIGRvIHRoZQpyaWdodCB0aGluZz8K
ClRoYW5rcyE=
