Return-Path: <bpf+bounces-1129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F870E5EA
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A31C20DAD
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7521CF8;
	Tue, 23 May 2023 19:47:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F741F934
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 19:47:17 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E3120
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:47:15 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 52192C151B39
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684871235; bh=MvTtpNEhWliZRgkjz75J+cd4hOV1lfKqikX9GvAWk7I=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gI2CIU3VxbgSACEViFbX3/r8bQrFzHY9qB9nJGqH8MXCeWBVStaoO1XhmWzZzNkdA
	 Mw4uoXoeMuQGwYEFZrxenY/p3/9cBNO+dqhbZAgVjfsmXuN7ZCngoS6K2vFqZYtOwU
	 EVkI6wtthPYWUUJ3JiwZYpM0xWwe6rbnnTd9vkqQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue May 23 12:47:15 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 34E88C151539;
	Tue, 23 May 2023 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684871235; bh=MvTtpNEhWliZRgkjz75J+cd4hOV1lfKqikX9GvAWk7I=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gI2CIU3VxbgSACEViFbX3/r8bQrFzHY9qB9nJGqH8MXCeWBVStaoO1XhmWzZzNkdA
	 Mw4uoXoeMuQGwYEFZrxenY/p3/9cBNO+dqhbZAgVjfsmXuN7ZCngoS6K2vFqZYtOwU
	 EVkI6wtthPYWUUJ3JiwZYpM0xWwe6rbnnTd9vkqQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D3826C151539
 for <bpf@ietfa.amsl.com>; Tue, 23 May 2023 12:47:13 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.098
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gnu.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UFowFchZ6Ccn for <bpf@ietfa.amsl.com>;
 Tue, 23 May 2023 12:47:09 -0700 (PDT)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id DCC7DC14F6EC
 for <bpf@ietf.org>; Tue, 23 May 2023 12:47:09 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemarch@gnu.org>)
 id 1q1XyN-0003g7-L4; Tue, 23 May 2023 15:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=DzrZ/h7jcyKJ4mEHXUnBoi307ryxUGh8iTJWX7zqAcQ=; b=nY1OUErRkEqSh0AJ1Auo
 HvI8hAQxXYaakatRMVW9odnZnuX6fF6NBPZPIo5rm+WNMZaMlRp3ZIl9tYPY1msQkAijNzzHXIFJ1
 mt4wzn4wQ+KpvIj5sx8dH0sR1MNROWeZQkbIpVQzAFu/lrBv05u2f3h0j4oMzHAa4cxJMYlLtltLd
 whJg5jpwr7TvTixRfi2aFPtKWwa8ktIsdbLV5WIEQUxDJtLF9sXAcxvXWosC6FzgbwSuSPNB5V4/v
 waoYSV4cQQhtu6xKy63JkjdO1nVhgHpbsyODI7I1i7R4TcFpnc+YPOCUJPDPMg+fJ3Gm8l5ZZBq0k
 g+ke9NcMk667Gg==;
Received: from [141.143.193.79] (helo=termi)
 by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemarch@gnu.org>)
 id 1q1XyN-0001Mx-7R; Tue, 23 May 2023 15:47:07 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Erik Kline <ek.ietf@gmail.com>
Cc: David Vernet <void@manifault.com>,  Dave Thaler <dthaler@microsoft.com>,
 "bpf@ietf.org" <bpf@ietf.org>,  bpf <bpf@vger.kernel.org>,  "Suresh
 Krishnan (sureshk)" <sureshk@cisco.com>,  Christoph Hellwig
 <hch@infradead.org>,  Alexei Starovoitov <ast@kernel.org>
In-Reply-To: <CAMGpriVpc5qdtqAObO1nu64kidt6C4UFp_FJ_Ht+DThMHNX-CQ@mail.gmail.com>
 (Erik Kline's message of "Tue, 23 May 2023 12:42:03 -0700")
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
 <PH7PR21MB3878A4135C14B318DD43365CA340A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523171535.GE20100@maniforge> <20230523190814.GA32582@maniforge>
 <CAMGpriVpc5qdtqAObO1nu64kidt6C4UFp_FJ_Ht+DThMHNX-CQ@mail.gmail.com>
Date: Tue, 23 May 2023 21:47:03 +0200
Message-ID: <87leheu8y0.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/avaHEXdDMk06CeEoGiF8pQNok5k>
Subject: Re: [Bpf] IETF BPF working group draft charter
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

Cj4gaG93IGFib3V0IGlmIHdlIHB1bGwgQUJJIGJ1dCBsZWF2ZSBFTEY/CgpUaGUgRUxGIGFyY2hp
dGVjdHVyZS1zcGVjaWZpYyBjb25maWd1cmF0aW9uIGFuZCBleHRlbnNpb25zIGFyZQp0cmFkaXRp
b25hbGx5IHBhcnQgb2YgdGhlIHBzQUJJLiAgQ2hhcHRlciA0IE9iamVjdCBGaWxlcy4KCj4KPiBP
biBUdWUsIE1heSAyMywgMjAyMyBhdCAxMjowOOKAr1BNIERhdmlkIFZlcm5ldCA8dm9pZEBtYW5p
ZmF1bHQuY29tPiB3cm90ZToKPj4KPj4gT24gVHVlLCBNYXkgMjMsIDIwMjMgYXQgMTI6MTU6MzVQ
TSAtMDUwMCwgRGF2aWQgVmVybmV0IHdyb3RlOgo+PiA+IE9uIFR1ZSwgTWF5IDIzLCAyMDIzIGF0
IDA0OjUwOjQyUE0gKzAwMDAsIERhdmUgVGhhbGVyIHdyb3RlOgo+PiA+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQo+PiA+ID4gPiBGcm9tOiBEYXZpZCBWZXJuZXQgPHZvaWRAbWFuaWZh
dWx0LmNvbT4KPj4gPiA+ID4gU2VudDogVHVlc2RheSwgTWF5IDIzLCAyMDIzIDk6MzIgQU0KPj4g
PiA+ID4gVG86IERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+Cj4+ID4gPiA+IENj
OiBKb3NlIEUuIE1hcmNoZXNpIDxqZW1hcmNoQGdudS5vcmc+OyBicGZAaWV0Zi5vcmc7IGJwZgo+
PiA+ID4gPiA8YnBmQHZnZXIua2VybmVsLm9yZz47IEVyaWsgS2xpbmUgPGVrLmlldGZAZ21haWwu
Y29tPjsgU3VyZXNoIEtyaXNobmFuCj4+ID4gPiA+IChzdXJlc2hrKSA8c3VyZXNoa0BjaXNjby5j
b20+OyBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+Owo+PiA+ID4gPiBBbGV4
ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgo+PiA+ID4gPiBTdWJqZWN0OiBSZTogW0Jw
Zl0gSUVURiBCUEYgd29ya2luZyBncm91cCBkcmFmdCBjaGFydGVyCj4+ID4gPiA+Cj4+ID4gPiA+
IE9uIFRodSwgTWF5IDE4LCAyMDIzIGF0IDA3OjQyOjExUE0gKzAwMDAsIERhdmUgVGhhbGVyIHdy
b3RlOgo+PiA+ID4gPiA+IEpvc2UgRS4gTWFyY2hlc2kgPGplbWFyY2hAZ251Lm9yZz4gd3JvdGU6
Cj4+ID4gPiA+ID4gPiBJIHdvdWxkIHRoaW5rIHRoYXQgdGhlIHdheSB0aGUgeDg2XzY0LCBhYXJj
aDY0LCByaXNjLXYsIHNwYXJjLCBtaXBzLAo+PiA+ID4gPiA+ID4gcG93ZXJwYyBhcmNoaXRlY3R1
cmVzLCBhbG9uZyB3aXRoIHRoZWlyIHZhcmlhbnRzLCBoYW5kbGUgdGhlaXIgRUxGCj4+ID4gPiA+
ID4gPiBleHRlbnNpb25zIGFuZCBwc0FCSSwgZW5zdXJlcyBpbnRlcm9wZXJhYmlsaXR5IGdvb2Qg
ZW5vdWdoIGZvciB0aGUKPj4gPiA+ID4gcHJvYmxlbSBhdCBoYW5kLCBidXQgb2suCj4+ID4gPiA+
ID4gPiBJJ20gZGVmaW5pdGVseSBub3QgYW4gZXhwZXJ0IGluIHRoZXNlIG1hdHRlcnMuCj4+ID4g
PiA+ID4KPj4gPiA+ID4gPiBJIGFtIG5vdCBmYW1pbGlhciBlbm91Z2ggd2l0aCB0aG9zZSB0byBt
YWtlIGFueSBjb21tZW50IGFib3V0IHRoYXQuCj4+ID4gPiA+Cj4+ID4gPiA+IEhpIERhdmUsCj4+
ID4gPiA+Cj4+ID4gPiA+IFRha2luZyBhIHN0ZXAgYmFjayBoZXJlLCBwZXJoYXBzIHdlIG5lZWQg
dG8gdGhpbmsgYWJvdXQgYWxsIG9mIHRoaXMgbW9yZQo+PiA+ID4gPiBnZW5lcmljYWxseSBhcyAi
QUJJIiwgcmF0aGVyIHRoYW4gRUxGICJleHRlbnNpb25zIiwgImJpbmRpbmdzIiwgZXRjLiAgSW4g
bXkKPj4gPiA+ID4gb3BpbmlvbiB0aGlzIHdvdWxkIGluY2x1ZGUsIGF0IGEgbWluaW11bSwgdGhl
IGZvbGxvd2luZyBpdGVtcyBmcm9tIHRoZSBjdXJyZW50Cj4+ID4gPiA+IHByb3Bvc2VkIFdHIGNo
YXJ0ZXI6Cj4+ID4gPiA+Cj4+ID4gPiA+ICogdGhlIGVCUEYgYmluZGluZ3MgZm9yIHRoZSBFTEYg
ZXhlY3V0YWJsZSBmaWxlIGZvcm1hdCwKPj4gPiA+ID4KPj4gPiA+ID4gKiB0aGUgcGxhdGZvcm0g
c3VwcG9ydCBBQkksIGluY2x1ZGluZyBjYWxsaW5nIGNvbnZlbnRpb24sIGxpbmtlcgo+PiA+ID4g
PiAgIHJlcXVpcmVtZW50cywgYW5kIHJlbG9jYXRpb25zLAo+PiA+ID4gPgo+PiA+ID4gPiBBcyBm
YXIgYXMgSSBrbm93IChwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcpLCB0aGVyZSBpc24n
dCByZWFsbHkgYSBwcmVjZWRlbmNlCj4+ID4gPiA+IGZvciBzdGFuZGFyZGl6aW5nIEFCSXMgbGlr
ZSB0aGlzLiBGb3IgZXhhbXBsZSwgeDg2IGNhbGxpbmcgY29udmVudGlvbnMgYXJlIG5vdAo+PiA+
ID4gPiBzdGFuZGFyZGl6ZWQuICBTb2xhcmlzLCBMaW51eCwgRnJlZUJTRCwgbWFjT1MsIGV0YyBh
bGwgZm9sbG93IHRoZSBTeXN0ZW0gVgo+PiA+ID4gPiBBTUQ2NCBBQkksIGJ1dCBNaWNyb3NvZnQg
b2YgY291cnNlIGRvZXMgbm90LiBBcyBKb3NlIHBvaW50ZWQgb3V0LCBzdWNoCj4+ID4gPiA+IHN0
YW5kYXJkcyBleHRlbnNpb25zIGRvIG5vdCBleGlzdCBmb3IgcHNBQkkgRUxGIGV4dGVuc2lvbnMg
Zm9yIHZhcmlvdXMKPj4gPiA+ID4gYXJjaGl0ZWN0dXJlcyBlaXRoZXIuCj4+ID4gPiA+Cj4+ID4g
PiA+IFdoaWxlIGl0IG1heSBiZSB0aGF0IHdlIGRvIGVuZCB1cCBuZWVkaW5nIHRvIHN0YW5kYXJk
aXplIHRoZXNlIEFCSXMgZm9yIEJQRiwKPj4gPiA+ID4gSSdtIGJlZ2lubmluZyB0byB0aGluayB0
aGF0IHdlIHNob3VsZCBqdXN0IHJlbW92ZSB0aGVtIGZyb20gdGhlIGN1cnJlbnQgV0cKPj4gPiA+
ID4gY2hhcnRlciwgYW5kIGNvbnNpZGVyIHN0YW5kYXJkaXppbmcgdGhlbSBhdCBhIGxhdGVyIHRp
bWUgaWYgaXQncyBjbGVhciB0aGF0IGl0J3MKPj4gPiA+ID4gYWN0dWFsbHkgbmVjZXNzYXJ5LiBJ
IHRoaW5rIHRoaXMgaXMgZXNwZWNpYWxseSB0cnVlIGdpdmVuIHRoYXQgd2UgZG9uJ3Qgc2VlbSB0
byBiZQo+PiA+ID4gPiBnZXR0aW5nIGFueSBjbG9zZXIgdG8gaGF2aW5nIGNvbnNlbnN1cywgYW5k
IHRoYXQgd2UncmUgdmVyeSBzaG9ydCBvbiB0aW1lIGdpdmVuCj4+ID4gPiA+IHRoYXQgRXJpayBp
cyBnb2luZyB0byBiZSBwcm9wb3NpbmcgdGhlIGNoYXJ0ZXIgdG8gdGhlIHJlc3Qgb2YgdGhlIEFE
cyBpbiBqdXN0IHR3bwo+PiA+ID4gPiBkYXlzIG9uIDUvMjUuCj4+ID4gPiA+Cj4+ID4gPiA+IFRo
YW5rcywKPj4gPiA+ID4gRGF2aWQKPj4gPiA+Cj4+ID4gPiBJIGNhbiB0ZWxsIHlvdSBpdCdzIHZl
cnkgaW1wb3J0YW50IHRvIHRob3NlIHdobyB3b3JrIG9uIHRoZQo+PiA+ID4gZWJwZi1mb3Itd2lu
ZG93cyBwcm9qZWN0IHRoYXQgdGhlIEVMRiBmb3JtYXQgaXMgY29tbW9uIGJldHdlZW4KPj4gPiA+
IExpbnV4IGFuZCBXaW5kb3dzIHNvIHRoYXQgdG9vbHMgbGlrZQo+PiA+ID4gbGx2bS1vYmpkdW1w
IGFuZCBicGZ0b29sIGFuZCBvdGhlciBCUEYtc3BlY2lmaWMgRUxGIHBhcnNpbmcgdG9vbHMgd29y
ayBmb3IgYm90aAo+PiA+ID4gTGludXggYW5kIFdpbmRvd3MuICAgV2UgZG9uJ3Qgd2FudCBXaW5k
b3dzIHRvIGRpdmVyZ2UuCj4+ID4KPj4gPiBCZSB0aGF0IGFzIGl0IG1heSwgYXMgSSBzYWlkIGJl
Zm9yZSwgdG8gbXkga25vd2xlZGdlIHRoZXJlJ3Mgbm8KPj4gPiBwcmVjZWRlbmNlIGF0IGFsbCBm
b3Igc3RhbmRhcmRpemluZyBBQkkgbGlrZSB0aGlzLiBJcyB0aGVyZSBhIHJlYXNvbgo+PiA+IHRo
YXQgeW91IHRoaW5rIFdpbmRvd3Mgd291bGQgZGl2ZXJnZSBpZiB3ZSBkaWRuJ3Qgc3RhbmRhcmRp
emUgdGhlIEFCST8KPj4gPgo+PiA+IEkgcmVhbGl6ZSB0aGF0IEknbSBlc3NlbnRpYWxseSBzYXlp
bmcsICJIZXksIHByZXRlbmQgdGhlcmUncyBhIHN0YW5kYXJkCj4+ID4gYW5kIGRvbid0IGRpdmVy
Z2UiLCBidXQgaWYgdGhhdCdzIHdoYXQgdGhlIGVudGlyZSByZXN0IG9mIHRoZSBpbmR1c3RyeQo+
PiA+IGhhcyBkb25lIHVwIHVudGlsIHRoaXMgcG9pbnQgd2l0aCBhbGwgb3RoZXIgcHNBQklzLCB0
aGVuIGl0IHNlZW1zIGxpa2UgYQo+PiA+IHJlYXNvbmFibGUgZXhwZWN0YXRpb24uCj4+ID4KPj4g
PiA+IEFzIHN1Y2gsIEkgZmVlbCBzdHJvbmdseSB0aGF0IGl0IGlzIGEgcmVxdWlyZW1lbnQgdG8g
YmUgc3RhbmRhcmRpemVkIHJpZ2h0IGF3YXkuCj4+ID4KPj4gPiBJIGhhdmUgdG8gcmVzcGVjdGZ1
bGx5IGRpc2FncmVlLiBJIHRoaW5rIHRoZXJlIGFyZSBtdWNoIGJpZ2dlciBmaXNoIHRvCj4+ID4g
ZnJ5LCBzdWNoIGFzIHN0YW5kYXJkaXppbmcgdGhlIElTQS4gVW5sZXNzIHdlIHJlYWxseSBoYXZl
IGEgZ29vZCByZWFzb24KPj4gPiBmb3IgZGl2ZXJnaW5nIGZyb20gaW5kdXN0cnkgbm9ybXMsIHN0
YW5kYXJkaXppbmcgb24gQUJJIG5vdyBmZWVscyB0byBtZQo+PiA+IGxpa2Ugd2UncmUgcHV0dGlu
ZyB0aGUgY2FydCBiZWZvcmUgdGhlIGhvcnNlLgo+Pgo+PiBIaSBEYXZlIGV0IGFsLAo+Pgo+PiBG
WUksIEkganVzdCBzZW50IG91dCBhIEdpdEh1YiBQUiB0byByZW1vdmUgdGhlc2UgbGluZXMgZnJv
bSB0aGUgcHJvcG9zZWQKPj4gV0cgY2hhcnRlcjogaHR0cHM6Ly9naXRodWIuY29tL2VrbGluZS9i
cGYvcHVsbC81L2ZpbGVzLiBJIHRob3VnaHQgaXQgd2FzCj4+IHBydWRlbnQgdG8gZ28gYWhlYWQg
YW5kIG9wZW4gdGhlIFBSIG5vdyBnaXZlbiBob3cgY2xvc2Ugd2UgYXJlIHRvIHRoZQo+PiA1LzI1
IG1lZXRpbmcsIGFuZCB0aGF0IHdlIGRvbid0IHNlZW0gdG8gYmUgYW55IGNsb3NlciB0byBnZXR0
aW5nCj4+IGNvbnNlbnN1cyBoZXJlLgo+Pgo+PiBXZSBjYW4gKGFuZCBzaG91bGQpIGNvbnRpbnVl
IHRoZSBkaXNjdXNzaW9uIGhlcmUsIGJ1dCBteSB0d28gY2VudHMgaXMKPj4gdGhhdCB1bmxlc3Mg
dGhlcmUncyBhIHN0cm9uZyByZWFzb24gdG8ga2VlcCBBQkkgc3RhbmRhcmRpemF0aW9uIHdpdGhp
bgo+PiBzY29wZSBvZiB0aGUgV0csIHRoYXQgaXQgbWFrZXMgc2Vuc2UgdG8gcmVtb3ZlIHRoZXNl
IGJ1bGxldHMuCj4+Cj4+IFRoYXQgc2FpZCwgaWYgdGhlIGRpc2N1c3Npb24gZGllcyBkb3duIGFu
ZC9vciBkb2Vzbid0IGNvbnRpbnVlLCBJTUhPIGl0Cj4+IHdvdWxkIGJlIHBydWRlbnQgdG8gbWVy
Z2UgdGhlIFBSLiBJIGRvbid0IHRoaW5rIG91ciBkZWZhdWx0IHBvc2l0aW9uCj4+IHNob3VsZCBi
ZSB0byBkZXZpYXRlIGZyb20gd2VsbC1lc3RhYmxpc2hlZCBpbmR1c3RyeS13aWRlIHByZWNlZGVu
Y2UsCj4+IHdpdGggdGhlIG9udXMgYmVpbmcgb24gdGhvc2UgYWR2b2NhdGluZyBmb3IgZm9sbG93
aW5nIGluZHVzdHJ5IG5vcm1zIHRvCj4+IHByb3ZlIHRoYXQgd2UgZG9uJ3QgbmVlZCB0byBkaXNj
dXNzIGl0LiBBZ2FpbiwgSSBtYXkgYmUgbWlzc2luZyBzb21lCj4+IGltcG9ydGFudCBjb250ZXh0
IGhlcmUsIHNvIGFwb2xvZ2llcyBpZiB0aGF0J3MgdGhlIGNhc2UuCj4+Cj4+IFRoYW5rcywKPj4g
RGF2aWQKPj4KPj4gPiBKdXN0IHRvIGJlIHZlcnkgY2xlYXI6IEkgY291bGQgYmUgdG90YWxseSB3
cm9uZyBoZXJlLCBhbmQgaXQgY291bGQgYmUKPj4gPiB2ZXJ5IGltcG9ydGFudCB0byBkZXZpYXRl
IGZyb20gaW5kdXN0cnkgbm9ybXMgYW5kIHN0YW5kYXJkaXplIEFCSSBhcwo+PiA+IHBhcnQgb2Yg
dGhlIGluaXRpYWwgV0cgY2hhcnRlci4gSG93ZXZlciwgSU1ITywgYSBwb3NpdGl2ZSBjbGFpbSBs
aWtlCj4+ID4gdGhhdCBuZWVkcyB0byBjb21lIHdpdGggY2xlYXIgc3Vic3RhbnRpYXRpb24uIFRo
ZSByZWFsaXR5IGlzIHRoYXQKPj4gPiBkZXZpYXRpbmcgZnJvbSBpbmR1c3RyeSBub3JtcyBhbmQg
c3RhbmRhcmRpemluZyBvbiBBQkkgd2lsbCBoYXZlIGl0cyBvd24KPj4gPiBjb3N0cyBhbmQgY29u
c2VxdWVuY2VzLgo+PiA+Cj4+ID4gPiBIZW5jZSBJIHdvdWxkIG5vdCB3YW50IHRoaXMgcmVtb3Zl
ZCBmcm9tIHRoZSBjaGFydGVyIHVubGVzcyB0aGVyZSdzIGFuIGVmZm9ydAo+PiA+ID4gdG8gZG8g
aXQgc29tZXdoZXJlIGVsc2UgcmlnaHQgYXdheSwgd2hpY2ggd291bGQgc2VlbSB0byBpbmNyZWFz
ZSB0aGUgY29vcmRpbmF0aW9uCj4+ID4gPiBidXJkZW4uCgotLSAKQnBmIG1haWxpbmcgbGlzdApC
cGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

