Return-Path: <bpf+bounces-27972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA788B4028
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E2FB23AF2
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14424179AD;
	Fri, 26 Apr 2024 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UGiRDVRB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="AwNv1DEW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M51om0a4"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC968BA45
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159854; cv=none; b=CNMQcgHy+o4D0eAcuvA52TIODy5rtTyUzSeeOUQ7kVtbDKg9hhqCnNEuYs+PReD/v/fmbI9lrO+uNtI8sKWx5zb6Uz+h1nMbMTdDfmKDHBdgZcRoywy5vo3x3ux6yPFpHa6bKPJl6FxP/8jOAuskWDvhOctZaYdYpmlXOKoTMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159854; c=relaxed/simple;
	bh=YkmIn2N7X/Fgm7rNGuYaSJOe1VTVDYaEdke+4aC6Ulc=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=Oyos9IZBomCdde+gazYV5g3BOOkcJ5+qntIBeyxoCXq+6F5AEnbw1SGvUidTUVnGGtrS1VrwVMibyBYO2r4fjPFPGJNqtqCTjEos0TrNBIxAQcIGgiTWJNYvK69XYAFo/ZjXVNWioaIWX7pLpVIgWmCIUjbTZhdvg+uUu/dxRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=UGiRDVRB; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=AwNv1DEW reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M51om0a4 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 71145C180B71
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714159852; bh=YkmIn2N7X/Fgm7rNGuYaSJOe1VTVDYaEdke+4aC6Ulc=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGiRDVRBugOLZ27+AqqW8sNLzEiRBrIlgMq0O811fWwuynIAUMHTAwcvB0zR86Ast
	 3KwS6SY0WHHYGSP76FqPHuzWnkpaLQ727WD58Uoh/mvC04UP/lMBYuFYeyLGW9T0/M
	 2OyZ4TLBp4wBXUCx09w07Gy/gc2qZ1Yv8FG4Y0rM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 38471C14F702;
 Fri, 26 Apr 2024 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1714159852; bh=YkmIn2N7X/Fgm7rNGuYaSJOe1VTVDYaEdke+4aC6Ulc=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=AwNv1DEWvL89skehW3eaASOIuf9t+QoFKR5lRkHy8q736Xog5ARWqWo/lehCQlOih
 K21/AykeUff3XGgHsFpzR8sGDA2f8NPQnLGZtOlC+U5ISesoVmwLK0YtRdvkVsBAYZ
 zjYtm0829TYe8A+nAhkKuCdgepNQnSCmDbYpXD/w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 05A0EC14F702
 for <bpf@ietfa.amsl.com>; Fri, 26 Apr 2024 12:30:50 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vMuwRWXUrUkP for <bpf@ietfa.amsl.com>;
 Fri, 26 Apr 2024 12:30:44 -0700 (PDT)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C8C6DC14F6E4
 for <bpf@ietf.org>; Fri, 26 Apr 2024 12:30:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-60274726da6so1809406a12.2
 for <bpf@ietf.org>; Fri, 26 Apr 2024 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1714159844; x=1714764644; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=c7oFPJ/9s3WV/rpddHBChs//6gHJrZ8yZzYu5cYUrig=;
 b=M51om0a4+4INhceZW+PV1xJ07Uqo9Nh7KElfdVCwm1yHj5Azc1+BvA4eBU3CreDQhe
 /Mvd99nUB7c5qpeiZ+duq1BpN9KhR0Ew+HDFOvEthXwfsNNReR16HXzVe6mzcKoCaxKq
 LVnk0I5GPLvPd2tyhp1FkeQQfaZfwBTvVcP5x4IK2qVzzvgapMw+BQ203dW9iJPCSKQz
 ll3rE4SisAPorXf+LK/eUUxqbu6SRphxHn94JA0Ke0vBUMQ4RGZ+B5QuZO9Hp3zBf1AF
 cwx9lVhvaHTTfEnyEORW3X8hunnQgGGmPgSG50xYSBmzkpERp+8Io/yZPeU0oegYO3oG
 j8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714159844; x=1714764644;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c7oFPJ/9s3WV/rpddHBChs//6gHJrZ8yZzYu5cYUrig=;
 b=qcg1N/LGfUuKUATD715aXxtB35IwB1gM0dcvB+zPygiXRoQWXVTKELtjAE11/tzERk
 U/4E/3PSpk3atYD9V3s8EROBvX2I6EL2uWleu6gvj5e2GsXtPW9nV8xbOYfLE3VHxqBQ
 G2+tKf8aVGaCMZYpVnZTCZDcf/oJ9cVsW6j3Vw6yaLWs3bd5l+PvG8RH+1wXTId7mS1w
 OoUCf3ZsZGaCdP5uErr09sNWRCTCTbCJiJigzy9b89rQCLZdUj+sm5EM9oaQZbDTVnjH
 PpiQTUVdNdCsDEvX8zlVqtBoqj+FnB93GNWJPcywuwA4jvx0Z5Bd40Oafu/5uc5NO9TT
 nN5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYtY2TI9ixGjyv5xSEZjZSqbC9ORprrvx9byzQ6lrgf6HVX9pVXKRcWvlGeFZcrbCoO5lStRNbH2QWLOI=
X-Gm-Message-State: AOJu0YyrA3DohcQR0aoAMb3F6EhaDZ+9u/XD726EdGflmnSmLboEEs2z
 b4q4f9U7drzKxCsICCI8e35UyjGiKJvu8A+vq9F1pyYAODKWi0Sl
X-Google-Smtp-Source: AGHT+IG7SEoXxN1aZkPs+qK2scgk9EVMEr8uPopx0YMZlAGltldLBaw6I2e4vXj7h7dACjkzzDWYDQ==
X-Received: by 2002:a17:90a:4206:b0:2b0:303f:ab84 with SMTP id
 o6-20020a17090a420600b002b0303fab84mr3920389pjg.14.1714159844217; 
 Fri, 26 Apr 2024 12:30:44 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 l5-20020a654485000000b005d8b2f04eb7sm12570514pgq.62.2024.04.26.12.30.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Apr 2024 12:30:43 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>
Cc: "'bpf'" <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240426171103.3496-1-dthaler1968@gmail.com>
 <CAADnVQLmu-v30D=JP75Cd0qBhDXm8izAnUnyZZ4-QwyM67nNww@mail.gmail.com>
In-Reply-To: <CAADnVQLmu-v30D=JP75Cd0qBhDXm8izAnUnyZZ4-QwyM67nNww@mail.gmail.com>
Date: Fri, 26 Apr 2024 12:30:41 -0700
Message-ID: <0dae01da9810$3a657fc0$af307f40$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDf9I+jjNNnBl+gCvpsjooEkTqcQwHzRDvSs2CcepA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/6-kVgHgqxe9Q7maeaEASD5YvQbM>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify PC use in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEFsZXhlaSBTdGFyb3ZvaXRvdiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4KPiBTZW50OiBGcmlkYXksIEFwcmlsIDI2LCAy
MDI0IDEyOjIyIFBNCj4gVG86IERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNv
bT4KPiBDYzogYnBmIDxicGZAdmdlci5rZXJuZWwub3JnPjsgYnBmQGlldGYub3JnOyBEYXZlIFRo
YWxlcgo+IDxkdGhhbGVyMTk2OEBnbWFpbC5jb20+Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBicGYt
bmV4dF0gYnBmLCBkb2NzOiBDbGFyaWZ5IFBDIHVzZSBpbiBpbnN0cnVjdGlvbi1zZXQucnN0Cj4g
Cj4gT24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgMTA6MTHigK9BTSBEYXZlIFRoYWxlciA8ZHRoYWxl
cjE5NjhAZ29vZ2xlbWFpbC5jb20+Cj4gd3JvdGU6Cj4gPgo+ID4gVGhpcyBwYXRjaCBlbGFib3Jh
dGVzIG9uIHRoZSB1c2Ugb2YgUEMgYnkgZXhwYW5kaW5nIHRoZSBQQyBhY3JvbnltLAo+ID4gZXhw
bGFpbmluZyB0aGUgdW5pdHMsIGFuZCB0aGUgcmVsYXRpdmUgcG9zaXRpb24gdG8gd2hpY2ggdGhl
IG9mZnNldAo+ID4gYXBwbGllcy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFRoYWxlciA8
ZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20+Cj4gPiAtLS0KPiA+ICBEb2N1bWVudGF0aW9uL2Jw
Zi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCB8IDUgKysrKysKPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiBiL0RvY3Vt
ZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiBpbmRl
eCBiNDRiZGFjZDAuLjU1OTI2MjBjZiAxMDA2NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBm
L3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gQEAgLTQ2OSw2
ICs0NjksMTEgQEAgSlNMVCAgICAgIDB4YyAgICBhbnkgICAgICBQQyArPSBvZmZzZXQgaWYgZHN0
IDwgc3JjCj4gc2lnbmVkCj4gPiAgSlNMRSAgICAgIDB4ZCAgICBhbnkgICAgICBQQyArPSBvZmZz
ZXQgaWYgZHN0IDw9IHNyYyAgICAgICAgIHNpZ25lZAo+ID4gID09PT09PT09ICA9PT09PSAgPT09
PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+Cj4gPiArd2hlcmUgJ1BD
JyBkZW5vdGVzIHRoZSBwcm9ncmFtIGNvdW50ZXIsIGFuZCB0aGUgb2Zmc2V0IHRvIGluY3JlbWVu
dAo+ID4gK2J5IGlzIGluIHVuaXRzIG9mIDY0LWJpdCBpbnN0cnVjdGlvbnMgcmVsYXRpdmUgdG8g
dGhlIGluc3RydWN0aW9uCj4gPiArZm9sbG93aW5nIHRoZSBqdW1wIGluc3RydWN0aW9uLiAgVGh1
cyAnUEMgKz0gMScgcmVzdWx0cyBpbiB0aGUgbmV4dAo+ID4gK2luc3RydWN0aW9uIHRvIGV4ZWN1
dGUgYmVpbmcgdHdvIDY0LWJpdCBpbnN0cnVjdGlvbnMgbGF0ZXIuCj4gCj4gVGhlIGxhc3QgcGFy
dCBpcyBjb25mdXNpbmcuCj4gInR3byA2NC1iaXQgaW5zdHJ1Y3Rpb25zIGxhdGVyIgo+IEknbSBz
dHJ1Z2dsaW5nIHRvIHVuZGVyc3RhbmQgdGhhdC4KPiBNYXliZSBzYXkgdGhhdCAnUEMgKz0gMScg
c2tpcHMgZXhlY3V0aW9uIG9mIHRoZSBuZXh0IGluc24/CgpJZiB0aGUgbmV4dCBpbnN0cnVjdGlv
biBpcyBhIDY0LWJpdCBpbW1lZGlhdGUgaW5zdHJ1Y3Rpb24KdGhhdCBzcGFucyAxMjggYml0cywg
ZG8geW91IG5lZWQgUEMgKz0gMSBvciBQQyArPSAyIHRvIHNraXAgaXQ/CkkgYXNzdW1lZCB5b3Un
ZCBuZWVkIFBDICs9IDIsIGluIHdoaWNoIGNhc2UgIlBDICs9IDEiIHdvdWxkCm5vdCBza2lwIGV4
ZWN1dGlvbiBvZiAidGhlIG5leHQgaW5zdHJ1Y3Rpb24iIGJ1dCB3b3VsZCB0cnkgdG8ganVtcCAK
aW50byBtaWQgaW5zdHJ1Y3Rpb24sIGFuZCBmYWlsIHZlcmlmaWNhdGlvbi4KSGVuY2UgbXkgYXR0
ZW1wdCBhdCAiNjQtYml0IGluc3RydWN0aW9uIiB3b3JkaW5nLgoKQWx0ZXJuYXRlIHdvcmRpbmcg
c3VnZ2VzdGlvbnMgd2VsY29tZS4KCkRhdmUKCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0
Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

