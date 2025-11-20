Return-Path: <bpf+bounces-75158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C013BC73D64
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 814BB4E3134
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 11:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D0313270;
	Thu, 20 Nov 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="lz0+PV+s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioVz8R0b"
X-Original-To: bpf@vger.kernel.org
Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90945231A41
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639714; cv=none; b=mkmzhZysbsnjkdByT2k/JFN6gCIXWVQcmHPReH2JHpFYM20Hh25rRLkp9hgh06F6FYJRgKuZZ/Wa+8AnVueRv+c2O/go453oQk785LYW3GFLksL507XvAEY03QaFvccG3Xqa141S8H+qmOjRtdnZnTh4Hgvx4XHTfPjTT6LsYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639714; c=relaxed/simple;
	bh=xJl/AecJYJZRIslH5TSlQTwSLlGT8s/IPE/BF7nI59U=;
	h=Message-ID:Date:MIME-Version:To:References:In-Reply-To:CC:Subject:
	 Content-Type:From; b=oGA8WhWV+86O8Fajcj15GqKCSYhrcLTIKyocjKm6Yzdv9xDR2NB3sqonfn810ZG8LbWnEgppKnsydOEG7sA5gYue9sAkKbHBr50PpeL//kCNDeHbVEURQ2CUoi8lsX4s/Z2/JYaXTLsQ6W20PS12yxVzz3T+R1ZUC37oXtcY74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=lz0+PV+s; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioVz8R0b reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 11F4E8D25A2D
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1763639211; bh=xJl/AecJYJZRIslH5TSlQTwSLlGT8s/IPE/BF7nI59U=;
	h=Date:To:References:In-Reply-To:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lz0+PV+sN4/5zGfHREmMmUBXHCNcybUj2paeeBQgL8YEToSNRPKoIJGBCu0Mg77ld
	 OBZHmmL3AoPi/Sh5DOiFPgFnBM7aBSW40c6ZARUhEyzhsl8Y1ZuJbLdGiUbcuzlCiY
	 vOVX6nAU2rdkUjMNuJXu5BbvHx6TyjCMmq/mZKTs=
Received: from mail2.ietf.org (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id 0D98A8D25A2C
 for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 03:46:51 -0800 (PST)
X-Original-To: bpf@mail2.ietf.org
Delivered-To: bpf@mail2.ietf.org
Received: from localhost (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id DCE058D2596B
 for <bpf@mail2.ietf.org>; Thu, 20 Nov 2025 03:46:46 -0800 (PST)
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=kernel.org
Received: from mail2.ietf.org ([166.84.6.31])
 by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZ_ac-Ljs9yA for <bpf@mail2.ietf.org>;
 Thu, 20 Nov 2025 03:46:45 -0800 (PST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail2.ietf.org (Postfix) with ESMTPS id 448D88D2595B
 for <bpf@ietf.org>; Thu, 20 Nov 2025 03:46:39 -0800 (PST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F227B40270
 for <bpf@ietf.org>; Thu, 20 Nov 2025 11:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36546C4CEF1;
 Thu, 20 Nov 2025 11:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763639192;
 bh=Hjvk/TbZrxYtx11cm6+WsGhzGqGOEZoJxdE6pKvyKFg=;
 h=Date:Subject:From:To:References:Cc:In-Reply-To:From;
 b=ioVz8R0bNOGlOaaifyAzGByIOEDvrh7xeaL2AO0SbdtNukNeoql72uzFyDW3yYqCX
 Vh6AwXNLHmzaAIVrfxDdEajEqFPQbxQ80jhLtdnWi2GQPJd2IE+7XR1dgtThA72fmI
 MgMiHZlA2vH9QeQIdOR2C168kFqaG+6nR6QrQc3CqQh5l3CCPYj2Wz4dU9Y2GAOISz
 /I7XSuhu+x8Mxa3UHJvyWCEZqvvZo5UwWR6uHc9mMPrulYrVe5uF9VHbid1q7A9KNs
 IphK/s0t0ADpbMrlkwGUnCOVg4hKisECVZF63MH4yEjMkK4T7uExu7GlT+j6jEDaoh
 T2Y1pWFwCot/w==
Message-ID: <74a4f889-33fa-4218-8eee-1980c6981dd6@kernel.org>
Date: Thu, 20 Nov 2025 11:46:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf <bpf@vger.kernel.org>, xdp-newbies <xdp-newbies@vger.kernel.org>,
 netdev@vger.kernel.org
References: <571ea41f-a6e9-4574-b5c5-737f0a0a9965@kernel.org>
Content-Language: en-GB
In-Reply-To: <571ea41f-a6e9-4574-b5c5-737f0a0a9965@kernel.org>
Message-ID-Hash: JH5TYEX4VFBWOSVAMLD2W7BLGOIW7ODK
X-Message-ID-Hash: JH5TYEX4VFBWOSVAMLD2W7BLGOIW7ODK
X-MailFrom: qmo@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_FOSDEM_2026_eBPF_Devroom_Call_for_Participation?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Mt5hh6ydeqLXiqEyYMhG2Pn5Mko>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Quentin Monnet <qmo@kernel.org>
From: Quentin Monnet <qmo=40kernel.org@dmarc.ietf.org>

SGkgYWxsLA0KDQpUaGUgY2FsbCBmb3IgcGFydGljaXBhdGlvbiBmb3IgdGhlIEJQRiBkZXZyb29t
IGF0IEZPU0RFTScyNiBpcyBjdXJyZW50bHkNCm9wZW4sIHVudGlsIERlY2VtYmVyIDFzdCAoZGV0
YWlscyBiZWxvdykuDQoNCklmIHlvdSBoYXZlIHRoaW5ncyB0byBzYXkgb24gdGhlIHRvcGljLCBw
bGVhc2UgY29uc2lkZXIgc2VuZGluZyBhDQpwcm9wb3NhbC4gSWYgeW91IGtub3cgcGVvcGxlIHdo
byBtaWdodCBiZSBpbnRlcmVzdGVkIGluIGF0dGVuZGluZyBvcg0KcHJlc2VudGluZywgcGxlYXNl
IGxldCB0aGVtIGtub3cuDQoNClRoYW5rcywNClF1ZW50aW4NCg0KDQoyMDI1LTEwLTMwIDEyOjQx
IFVUQyswMTAwIH4gUXVlbnRpbiBNb25uZXQgPHFtb0BrZXJuZWwub3JnPg0KPiBXZSBhcmUgZGVs
aWdodGVkIHRvIGFubm91bmNlIHRoZSBDYWxsIGZvciBQYXJ0aWNpcGF0aW9uIGZvciB0aGUgc2Vj
b25kDQo+IGVCUEYgRGV2cm9vbSBhdCBGT1NERU0hDQo+IA0KPiBNYXJrIHRoZSBEYXRlcw0KPiAt
LS0tLS0tLS0tLS0tLQ0KPiANCj4gKiBEZWNlbWJlciAxc3QsIDIwMjU6IFN1Ym1pc3Npb24gZGVh
ZGxpbmUNCj4gKiBEZWNlbWJlciAxNXRoLCAyMDI1OiBBbm5vdW5jZW1lbnQgb2YgYWNjZXB0ZWQg
dGFsa3MgYW5kIHNjaGVkdWxlDQo+ICogSmFudWFyeSAzMXN0LCAyMDI2OiBlQlBGIERldnJvb20g
YXQgRk9TREVNDQo+IA0KPiBlQlBGIGF0IEZPU0RFTQ0KPiAtLS0tLS0tLS0tLS0tLQ0KPiANCj4g
Rk9TREVNIGlzIGEgZnJlZSwgY29tbXVuaXR5LW9yZ2FuaXplZCBldmVudCBmb2N1c2luZyBvbiBv
cGVuIHNvdXJjZSwgYW5kDQo+IGFpbWluZyBhdCBnYXRoZXJpbmcgb3BlbiBzb3VyY2Ugc29mdHdh
cmUgZGV2ZWxvcGVycyBhbmQgY29tbXVuaXRpZXMgdG8NCj4gbWVldCwgbGVhcm4sIGFuZCBzaGFy
ZS4gSXQgdGFrZXMgcGxhY2UgYW5udWFsbHkgaW4gQnJ1c3NlbHMsIEJlbGdpdW0uDQo+IEFmdGVy
IGhvc3RpbmcgYSBudW1iZXIgb2YgZUJQRi1yZWxhdGVkIHRhbGtzIGluIHZhcmlvdXMgZGV2cm9v
bXMgb3Zlcg0KPiB0aGUgeWVhcnMsIEZPU0RFTSAyMDI2IHdlbGNvbWVzIGEgZGV2cm9vbSBkZWRp
Y2F0ZWQgdG8gZUJQRiBmb3IgdGhlDQo+IHNlY29uZCB0aW1lISBUaGlzIGRldnJvb20gYWltcyBh
dCBnYXRoZXJpbmcgdGFsa3MgYWJvdXQgdmFyaW91cyBhc3BlY3RzDQo+IG9mIGVCUEYsIGlkZWFs
bHkgb24gbXVsdGlwbGUgcGxhdGZvcm1zLg0KPiANCj4gVG9waWNzIG9mIEludGVyZXN0DQo+IC0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gSWYgeW91IGhhdmUgc29tZXRoaW5nIHRvIHByZXNlbnQg
YWJvdXQgZUJQRiwgd2Ugd291bGQgbG92ZSBmb3IgeW91IHRvDQo+IGNvbnNpZGVyIHN1Ym1pdHRp
bmcgYSBwcm9wb3NhbCB0byB0aGUgRGV2cm9vbS4NCj4gDQo+IFRoZSBwcm9qZWN0cyBvciB0ZWNo
bm9sb2dpZXMgZGlzY3Vzc2VkIGluIHRoZSB0YWxrcyBNVVNUIGJlIG9wZW4tc291cmNlLg0KPiAN
Cj4gVG9waWNzIG9mIGludGVyZXN0IGZvciB0aGUgRGV2cm9vbSBpbmNsdWRlIChidXQgYXJlIG5v
dCBsaW1pdGVkIHRvKToNCj4gDQo+ICogZUJQRiBkZXZlbG9wbWVudDogcmVjZW50IG9yIHByb3Bv
c2VkIGZlYXR1cmVzIChvbiBMaW51eCwgb24gb3RoZXINCj4gICBwbGF0Zm9ybXMsIG9yIGV2ZW4g
Y3Jvc3MtcGxhdGZvcm0pLCBzdWNoIGFzOg0KPiAgICAgKiBlQlBGIHByb2dyYW0gc2lnbmluZyBh
bmQgc3VwcGx5IGNoYWluIHNlY3VyaXR5DQo+ICAgICAqIFByb2ZpbGluZyBlQlBGIHdpdGggZUJQ
Rg0KPiAgICAgKiBlQlBGLWJhc2VkIHByb2Nlc3Mgc2NoZWR1bGVycw0KPiAgICAgKiBlQlBGIGlu
IHN0b3JhZ2UgZGV2aWNlcw0KPiAgICAgKiBlQlBGIHZlcmlmaWVyIGltcHJvdmVtZW50cyBvciBh
bHRlcm5hdGl2ZSBpbXBsZW1lbnRhdGlvbnMNCj4gICAgICogZUJQRiBmb3IgcHJvZmlsaW5nIEFJ
IHdvcmtsb2Fkcw0KPiAqIERlZXAtZGl2ZXMgb24gZXhpc3RpbmcgZUJQRiBmZWF0dXJlcw0KPiAq
IFdvcmtpbmcgd2l0aCBlQlBGOiBiZXN0IHByYWN0aWNlcywgY29tbW9uIG1pc3Rha2VzLCBkZWJ1
Z2dpbmcsIGV0Yy4NCj4gKiBlQlBGIHRvb2xjaGFpbiwgZm9yIGNvbXBpbGluZywgbWFuYWdpbmcs
IGRlYnVnZ2luZywgcGFja2FnaW5nLCBhbmQNCj4gICBkZXBsb3lpbmcgZUJQRiBwcm9ncmFtcyBh
bmQgcmVsYXRlZCBvYmplY3RzDQo+ICogZUJQRiBsaWJyYXJpZXMsIGluIEMvQysrLCBHbywgUnVz
dCwgb3Igb3RoZXIgbGFuZ3VhZ2VzDQo+ICogZUJQRiBpbiB0aGUgcmVhbCB3b3JsZCwgcHJvZHVj
dGlvbiB1c2UgY2FzZXMgYW5kIHRoZWlyIGltcGFjdA0KPiAqIGVCUEYgY29tbXVuaXR5IGVmZm9y
dHMgKGRvY3VtZW50YXRpb24sIHN0YW5kYXJkaXphdGlvbiwgY3Jvc3MtcGxhdGZvcm0NCj4gICBp
bml0aWF0aXZlcykNCj4gDQo+IFRoZSBsaXN0IGlzIG5vdCBleGhhdXN0aXZlLCBkb27igJl0IGhl
c2l0YXRlIHRvIHN1Ym1pdCB5b3VyIHByb3Bvc2FsIQ0KPiANCj4gRm9ybWF0DQo+IC0tLS0tLQ0K
PiANCj4gRk9TREVNIDIwMjYgd2lsbCBiZSBhbiBpbi1wZXJzb24gZXZlbnQgaW4gQnJ1c3NlbHMs
IEJlbGdpdW0uDQo+IFdlIGRvIG5vdCBhY2NlcHQgcmVtb3RlIHByZXNlbnRhdGlvbnMuDQo+IA0K
PiBXZeKAmXJlIGxvb2tpbmcgZm9yIDIwLSB0byAzMC1taW51dGUgcHJlc2VudGF0aW9ucy4gVGhl
IGR1cmF0aW9uIHNob3VsZA0KPiBpbmNsdWRlIHRpbWUgZm9yIHF1ZXN0aW9uczogYWxsb3cgYXQg
bGVhc3QgNSB0byAxMCBtaW51dGVzIHRvIGFuc3dlcg0KPiBxdWVzdGlvbnMgZnJvbSB0aGUgcHVi
bGljLg0KPiANCj4gTm90ZSB0aGF0IGR1ZSB0byB0aW1lIGNvbnN0cmFpbnRzLCB3ZSBtYXkgZW5k
IHVwIG9mZmVyaW5nIGEgc2xvdA0KPiBkdXJhdGlvbiBkaWZmZXJlbnQgdGhhbiB0aGUgb25lIHJl
cXVlc3RlZCB3aGVuIHN1Ym1pdHRpbmcuIElmIHlvdSBoYXZlDQo+IHNwZWNpZmljIGR1cmF0aW9u
IHJlcXVpcmVtZW50cywgd2UgZW5jb3VyYWdlIHlvdSB0byBtZW50aW9uIHRoZW0gaW4geW91cg0K
PiBwcm9wb3NhbC4NCj4gDQo+IFlvdSBjYW4gbG9vayBhdCBsYXN0IHllYXIncyBzY2hlZHVsZSBm
b3IgaW5zcGlyYXRpb24sIGF0DQo+IGh0dHBzOi8vYXJjaGl2ZS5mb3NkZW0ub3JnLzIwMjUvc2No
ZWR1bGUvdHJhY2svZWJwZi8NCj4gDQo+IEhvdyB0byBTdWJtaXQNCj4gLS0tLS0tLS0tLS0tLQ0K
PiANCj4gUGxlYXNlIHN1Ym1pdCB5b3VyIHByb3Bvc2FscyBvbiBQcmV0YWx4LCBGT1NERU3igJlz
IHN1Ym1pc3Npb25zIHRvb2wsIGF0DQo+IGh0dHBzOi8vcHJldGFseC5mb3NkZW0ub3JnL2Zvc2Rl
bS0yMDI2L2NmcA0KPiANCj4gTWFrZSBzdXJlIHRvIHNlbGVjdCDigJxlQlBG4oCdIGFzIHRoZSB0
cmFjay4NCj4gDQo+IENvZGUgb2YgQ29uZHVjdA0KPiAtLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEFs
bCBwYXJ0aWNpcGFudHMgYXQgRk9TREVNIGFyZSBleHBlY3RlZCB0byBhYmlkZSBieSB0aGUgRk9T
REVN4oCZcyBDb2RlIG9mDQo+IENvbmR1Y3QuIElmIHlvdXIgcHJvcG9zYWwgaXMgYWNjZXB0ZWQs
IHlvdSB3aWxsIGJlIHJlcXVpcmVkIHRvIGNvbmZpcm0NCj4gdGhhdCB5b3UgYWNjZXB0IHRoaXMg
Q29kZSBvZiBDb25kdWN0LiBZb3UgY2FuIGZpbmQgdGhpcyBjb2RlIGF0DQo+IGh0dHBzOi8vZm9z
ZGVtLm9yZy8yMDI2L3ByYWN0aWNhbC9jb25kdWN0Lw0KPiANCj4gRGV2cm9vbSBPcmdhbmlzZXJz
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gKiBBbGV4ZWkgU3Rhcm92b2l0b3YNCj4gKiBB
bmRyaWkgTmFrcnlpa28NCj4gKiBCaWxsIE11bGxpZ2FuDQo+ICogRGFuaWVsIEJvcmttYW5uDQo+
ICogRGltaXRhciBLYW5hbGlldg0KPiAqIFF1ZW50aW4gTW9ubmV0DQo+ICogWXVzaGVuZyBaaGVu
Zw0KPiANCj4gSWYgeW91IGhhdmUgcXVlc3Rpb25zIGFib3V0IGFueSBhc3BlY3RzIG9mIHRoaXMg
Q2FsbCBmb3IgUGFydGljaXBhdGlvbiwNCj4gcGxlYXNlIGVtYWlsIHVzIGF0IGVicGYtZGV2cm9v
bS1tYW5hZ2VyQGZvc2RlbS5vcmcsIGFuZCB3ZSB3aWxsIGRvIG91cg0KPiBiZXN0IHRvIGFzc2lz
dCB5b3UuDQo+IA0KPiBXZSBrZWVwIGFuIHVwLXRvLWRhdGUgdmVyc2lvbiBvZiB0aGlzIENhbGwg
Zm9yIFBhcnRpY2lwYXRpb24gYXQNCj4gaHR0cHM6Ly9lYnBmLmlvL2Zvc2RlbS0yMDI2Lmh0bWwN
Cg0KLS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNl
bmQgYW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

