Return-Path: <bpf+bounces-6611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D576BE1E
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 21:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4CF1C21021
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA53253C4;
	Tue,  1 Aug 2023 19:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01B4DC6B
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:49:47 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A35A2D4F
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 12:49:33 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3289EC151994
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690919373; bh=zkp1grJG75teNxml70ric5wsCU7FzDLFrJn+hyzTqu8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=nptAMa86Uh3Cj0rO48zOWj+2FAVPfpeHnojytr+oKXOFuOEBEGEL03afnupQYzrzk
	 BvpzTUUHOBBUMueF3KnnLDTfDyXEo2wD8nAGoD2sGPxxjQrFe3PWCjVR3Y27hb7+df
	 Yqw6Zc5w1Z+Jrgz4TKQHwi6zSzwKYU/+YIlDg6cY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Aug  1 12:49:33 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1EA69C151548;
	Tue,  1 Aug 2023 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690919373; bh=zkp1grJG75teNxml70ric5wsCU7FzDLFrJn+hyzTqu8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=nptAMa86Uh3Cj0rO48zOWj+2FAVPfpeHnojytr+oKXOFuOEBEGEL03afnupQYzrzk
	 BvpzTUUHOBBUMueF3KnnLDTfDyXEo2wD8nAGoD2sGPxxjQrFe3PWCjVR3Y27hb7+df
	 Yqw6Zc5w1Z+Jrgz4TKQHwi6zSzwKYU/+YIlDg6cY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1F530C151548
 for <bpf@ietfa.amsl.com>; Tue,  1 Aug 2023 12:49:32 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.905
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aJYkOD0jXvvk for <bpf@ietfa.amsl.com>;
 Tue,  1 Aug 2023 12:49:28 -0700 (PDT)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 42623C151530
 for <bpf@ietf.org>; Tue,  1 Aug 2023 12:49:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-63cf7cce5fbso41414376d6.0
 for <bpf@ietf.org>; Tue, 01 Aug 2023 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690919367; x=1691524167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VsubkDRJqP44SKDtlYDzRR13m+oCWB54EA9z/XG5i4=;
 b=4aCyC3oPgRtDj9S5F91+Pv5oHrgzl47up+HZbM3yv21dRNxPFOBzmFOZlwVMhVlWbl
 mdvfFYLSm1gOk8tBRh9UZ0FbdHF91GgcP+ib64+l1/nJRj5erL9rAYTwWPIH7jf0cIsT
 TdEgg36waR6AvDCJR4PnuArPiu2ooZLUCCavpBWzmUbTtGc6xgIEGwkXLdo4ppJiYPAS
 7mO6OtIaKH3pR+mt9yJUFmALIJLz32tQSsZFG9UzehABgwUTnxQmvj9XRQLDt4bYxUII
 TtV/pwt7yt8jPfV24PnjoLcxgCIPZa0a14YWRpWGGPwMTUkMBxc9VATko9zH1H1xaPJ7
 RcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690919367; x=1691524167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VsubkDRJqP44SKDtlYDzRR13m+oCWB54EA9z/XG5i4=;
 b=MWRYnYOEHyYsgxrME3Xa3am1xq58+oiHIYXa9DQswOhSbAwv3TcbASNaoSkzBXgYqV
 5NEpnQF1PvJLWDGV5zM2EPbGCFyzU7JQUcJu+Sz5Rb5bafaz4ghscbaqYl35aKVFBlvy
 U93+npC+1kS2R6vVJO8TR3mWr91yWkjAZrRRK6wuBINbWaNgZCQLR8H94k62XvnawDJR
 IoSV+cKHhC1bV2ChuW48LdP6rrlmErx3h1RqUXY1A5GyyiWFCfgWVDEqeEdB2oGTa9f9
 ajvVghEJF0omlhAjDO7QF9+3VGSy7/iz/a0Opl+k4+XTGZKFDQLjn/jnzW4P9tZEUeyk
 t+Aw==
X-Gm-Message-State: ABy/qLblCGw3rlE+CqpZ2veL9YostcLX6ImPlRYi3/GM8MLubGuErwaV
 KQYxs1bffvrmZxvqv0Rlz+K6fMRqqLQUsWYsF6J9Rg==
X-Google-Smtp-Source: APBJJlGgu6pvmnvYuAmQNc9KhJ/t4bc1s5FP49nh5MgDSTnQKTNjVLO5ATb10VmojNTJi7RFPxDLG6VTkwpvo4AX1vM=
X-Received: by 2002:a0c:a792:0:b0:632:2649:d719 with SMTP id
 v18-20020a0ca792000000b006322649d719mr11994174qva.30.1690919367034; Tue, 01
 Aug 2023 12:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730035156.2728106-1-hawkinsw@obs.cr>
 <20230730035156.2728106-2-hawkinsw@obs.cr>
 <20230801193538.GA472124@maniforge>
In-Reply-To: <20230801193538.GA472124@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 1 Aug 2023 15:49:16 -0400
Message-ID: <CADx9qWizG61pAwGROHaJuHY3DtKHPn28nXypuAaUtjs7T=qs8A@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/UMGuDa-8EB5LcvVJADsNFwCciME>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
 docs: Formalize type notation and function semantics in ISA standard
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

VGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2shIFJlc3BvbnNlcyBpbmxpbmUuCgpPbiBUdWUsIEF1
ZyAxLCAyMDIzIGF0IDM6MzXigK9QTSBEYXZpZCBWZXJuZXQgPHZvaWRAbWFuaWZhdWx0LmNvbT4g
d3JvdGU6Cj4KPiBPbiBTYXQsIEp1bCAyOSwgMjAyMyBhdCAxMTo1MTo1NlBNIC0wNDAwLCBXaWxs
IEhhd2tpbnMgd3JvdGU6Cj4gPiBHaXZlIGEgc2luZ2xlIHBsYWNlIHdoZXJlIHRoZSBzaG9ydGhh
bmQgZm9yIHR5cGVzIGFyZSBkZWZpbmVkIGFuZCB0aGUKPiA+IHNlbWFudGljcyBvZiBoZWxwZXIg
ZnVuY3Rpb25zIGFyZSBkZXNjcmliZWQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogV2lsbCBIYXdr
aW5zIDxoYXdraW5zd0BvYnMuY3I+Cj4gPiAtLS0KPiA+ICAuLi4vYnBmL3N0YW5kYXJkaXphdGlv
bi9pbnN0cnVjdGlvbi1zZXQucnN0ICAgfCA2NSArKysrKysrKysrKysrKysrKystCj4gPiAgRG9j
dW1lbnRhdGlvbi9zcGhpbngvcmVxdWlyZW1lbnRzLnR4dCAgICAgICAgIHwgIDIgKy0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlv
bi1zZXQucnN0IGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9u
LXNldC5yc3QKPiA+IGluZGV4IGZiODE1NGNlZGQ4NC4uOTczNzgzODhlMjBiIDEwMDY0NAo+ID4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5y
c3QKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlv
bi1zZXQucnN0Cj4gPiBAQCAtMTAsOSArMTAsNjggQEAgVGhpcyBkb2N1bWVudCBzcGVjaWZpZXMg
dmVyc2lvbiAxLjAgb2YgdGhlIGVCUEYgaW5zdHJ1Y3Rpb24gc2V0Lgo+ID4gIERvY3VtZW50YXRp
b24gY29udmVudGlvbnMKPiA+ICA9PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPgo+ID4gLUZv
ciBicmV2aXR5LCB0aGlzIGRvY3VtZW50IHVzZXMgdGhlIHR5cGUgbm90aW9uICJ1NjQiLCAidTMy
IiwgZXRjLgo+ID4gLXRvIG1lYW4gYW4gdW5zaWduZWQgaW50ZWdlciB3aG9zZSB3aWR0aCBpcyB0
aGUgc3BlY2lmaWVkIG51bWJlciBvZiBiaXRzLAo+ID4gLWFuZCAiczMyIiwgZXRjLiB0byBtZWFu
IGEgc2lnbmVkIGludGVnZXIgb2YgdGhlIHNwZWNpZmllZCBudW1iZXIgb2YgYml0cy4KPiA+ICtG
b3IgYnJldml0eSBhbmQgY29uc2lzdGVuY3ksIHRoaXMgZG9jdW1lbnQgcmVmZXJzIHRvIGZhbWls
aWVzCj4gPiArb2YgdHlwZXMgdXNpbmcgYSBzaG9ydGhhbmQgc3ludGF4IGFuZCByZWZlcnMgdG8g
c2V2ZXJhbCBoZWxwZXIKPiA+ICtmdW5jdGlvbnMgd2hlbiBleHBsYWluaW5nIHRoZSBzZW1hbnRp
Y3Mgb2Ygb3Bjb2Rlcy4gVGhlIHJhbmdlCj4KPiBuaXQ6IENhbiB3ZSB1c2UgYSBkaWZmZXJlbnQg
dGVybSB0aGFuICJoZWxwZXIgZnVuY3Rpb25zIiBoZXJlLCBqdXN0Cj4gYmVjYXVzZSBpdCdzIGFu
IG92ZXJsb2FkZWQgdGVybSBmb3IgQlBGLiBNYXliZSAic2hvcnRoYW5kIGZ1bmN0aW9ucyIgb3IK
PiAibW5lbW9uaWMgZnVuY3Rpb25zIj8gT3IganVzdCAiZnVuY3Rpb25zIj8KCkdyZWF0IGlkZWEu
IEkgbGlrZSB0aGUgdGVybSBtbmVtb25pYyBmdW5jdGlvbnMgKGdpdmVuIHRoYXQgd2UgdGFsawph
Ym91dCBtbmVtb25pY3Mgd2l0aCBvcGNvZGVzKS4gSSB3aWxsIGdvIHdpdGggdGhhdCB1bmxlc3Mg
dGhlcmUgaXMKYWRkaXRpb25hbCBndWlkYW5jZS4KCj4KPiA+ICtvZiB2YWxpZCB2YWx1ZXMgZm9y
IHRob3NlIHR5cGVzIGFuZCB0aGUgc2VtYW50aWNzIG9mIHRob3NlIGZ1bmN0aW9ucwo+ID4gK2Fy
ZSBkZWZpbmVkIGluIHRoZSBmb2xsb3dpbmcgc3Vic2VjdGlvbnMuCj4gPiArCj4gPiArVHlwZXMK
PiA+ICstLS0tLQo+ID4gK1RoaXMgZG9jdW1lbnQgcmVmZXJzIHRvIGludGVnZXIgdHlwZXMgd2l0
aCBhIG5vdGF0aW9uIG9mIHRoZSBmb3JtIGBTWGAKPgo+IEkgc3VnZ2VzdCByZXBsYWNpbmcgYFNY
YCB3aXRoIGBTbmAsIGFzIGBTWGAgaXMgc2hvcnQgZm9yIHNpZ24tZXh0ZW5zaW9uCj4gaW4gc2V2
ZXJhbCBpbnN0cnVjdGlvbnMuCgpHb29kIHBvaW50ISBXaWxsIGRvIQoKPgo+ID4gK3RoYXQgc3Vj
Y2luY3RseSBkZWZpbmVzIHdoZXRoZXIgdGhlaXIgdmFsdWVzIGFyZSBzaWduZWQgb3IgdW5zaWdu
ZWQKPiA+ICtudW1iZXJzIGFuZCB0aGUgYml0IHdpZHRoczoKPiA+ICsKPiA+ICs9PT0gPT09PT09
PQo+ID4gK2BTYCBNZWFuaW5nCj4gPiArPT09ID09PT09PT0KPiA+ICtgdWAgdW5zaWduZWQKPiA+
ICtgc2Agc2lnbmVkCj4gPiArPT09ID09PT09PT0KPiA+ICsKPiA+ICs9PT09PSA9PT09PT09PT0K
PiA+ICtgWGAgICBCaXQgd2lkdGgKPiA+ICs9PT09PSA9PT09PT09PT0KPiA+ICtgOGAgICA4IGJp
dHMKPiA+ICtgMTZgICAxNiBiaXRzCj4gPiArYDMyYCAgMzIgYml0cwo+ID4gK2A2NGAgIDY0IGJp
dHMKPiA+ICtgMTI4YCAxMjggYml0cwo+ID4gKz09PT09ID09PT09PT09PQo+ID4gKwo+ID4gK0Zv
ciBleGFtcGxlLCBgdTMyYCBpcyBhIHR5cGUgd2hvc2UgdmFsaWQgdmFsdWVzIGFyZSBhbGwgdGhl
IDMyLWJpdCB1bnNpZ25lZAo+ID4gK251bWJlcnMgYW5kIGBzMTZgIGlzIGEgdHlwZXMgd2hvc2Ug
dmFsaWQgdmFsdWVzIGFyZSBhbGwgdGhlIDE2LWJpdCBzaWduZWQKPiA+ICtudW1iZXJzLgo+ID4g
Kwo+ID4gK0Z1bmN0aW9ucwo+ID4gKy0tLS0tLS0tLQo+ID4gKyogYGh0b2JlMTZgOiBUYWtlcyBh
biB1bnNpZ25lZCAxNi1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+ICsg
IHJldHVybnMgdGhlIGVxdWl2YWxlbnQgbnVtYmVyIGFzIGFuIHVuc2lnbmVkIDE2LWJpdCBudW1i
ZXIgaW4gYmlnLWVuZGlhbgo+ID4gKyAgZm9ybWF0Lgo+ID4gKyogYGh0b2JlMzJgOiBUYWtlcyBh
biB1bnNpZ25lZCAzMi1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+ICsg
IHJldHVybnMgdGhlIGVxdWl2YWxlbnQgbnVtYmVyIGFzIGFuIHVuc2lnbmVkIDMyLWJpdCBudW1i
ZXIgaW4gYmlnLWVuZGlhbgo+ID4gKyAgZm9ybWF0Lgo+ID4gKyogYGh0b2JlNjRgOiBUYWtlcyBh
biB1bnNpZ25lZCA2NC1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+ICsg
IHJldHVybnMgdGhlIGVxdWl2YWxlbnQgbnVtYmVyIGFzIGFuIHVuc2lnbmVkIDY0LWJpdCBudW1i
ZXIgaW4gYmlnLWVuZGlhbgo+ID4gKyAgZm9ybWF0Lgo+ID4gKyogYGh0b2xlMTZgOiBUYWtlcyBh
biB1bnNpZ25lZCAxNi1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+ICsg
IHJldHVybnMgdGhlIGVxdWl2YWxlbnQgbnVtYmVyIGFzIGFuIHVuc2lnbmVkIDE2LWJpdCBudW1i
ZXIgaW4gbGl0dGxlLWVuZGlhbgo+ID4gKyAgZm9ybWF0Lgo+ID4gKyogYGh0b2xlMzJgOiBUYWtl
cyBhbiB1bnNpZ25lZCAzMi1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+
ICsgIHJldHVybnMgdGhlIGVxdWl2YWxlbnQgbnVtYmVyIGFzIGFuIHVuc2lnbmVkIDMyLWJpdCBu
dW1iZXIgaW4gbGl0dGxlLWVuZGlhbgo+ID4gKyAgZm9ybWF0Lgo+ID4gKyogYGh0b2xlNjRgOiBU
YWtlcyBhbiB1bnNpZ25lZCA2NC1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQK
PiA+ICsgIHJldHVybnMgdGhlIGVxdWl2YWxlbnQgbnVtYmVyIGFzIGFuIHVuc2lnbmVkIDY0LWJp
dCBudW1iZXIgaW4gbGl0dGxlLWVuZGlhbgo+ID4gKyAgZm9ybWF0Lgo+Cj4gSG1tLCBzb21lIG9m
IHRoZXNlIGZ1bmN0aW9ucyBhcmVuJ3QgYWN0dWFsbHkgdXNlZCBlbHNld2hlcmUgaW4gdGhlCj4g
ZG9jdW1lbnQuIE1heWJlIHVwZGF0ZSB0aGUgaHRve2IsbH1lTiBleGFtcGxlcyBsYXRlciBpbiB0
aGUgQnl0ZSBzd2FwCj4gaW5zdHJ1Y3Rpb25zIHNlY3Rpb24gdG8gbWF0Y2ggYnN3YXBOIHdoZXJl
IGFsbCB3aWR0aHMgYXJlIGlsbHVzdHJhdGVkIGluCj4gdGhlIGV4YW1wbGU/Cj4KCkFub3RoZXIg
Z3JlYXQgcG9pbnQuIFdpbGwgZG8hCgoKPiA+ICsqIGBic3dhcDE2YDogVGFrZXMgYW4gdW5zaWdu
ZWQgMTYtYml0IG51bWJlciBpbiBlaXRoZXIgYmlnLSBvciBsaXR0bGUtZW5kaWFuCj4gPiArICBm
b3JtYXQgYW5kIHJldHVybnMgdGhlIGVxdWl2YWxlbnQgbnVtYmVyIHdpdGggdGhlIHNhbWUgYml0
IHdpZHRoIGJ1dAo+ID4gKyAgb3Bwb3NpdGUgZW5kaWFubmVzcy4KPiA+ICsqIGBic3dhcDMyYDog
VGFrZXMgYW4gdW5zaWduZWQgMzItYml0IG51bWJlciBpbiBlaXRoZXIgYmlnLSBvciBsaXR0bGUt
ZW5kaWFuCj4gPiArICBmb3JtYXQgYW5kIHJldHVybnMgdGhlIGVxdWl2YWxlbnQgbnVtYmVyIHdp
dGggdGhlIHNhbWUgYml0IHdpZHRoIGJ1dAo+ID4gKyAgb3Bwb3NpdGUgZW5kaWFubmVzcy4KPiA+
ICsqIGBic3dhcDY0YDogVGFrZXMgYW4gdW5zaWduZWQgNjQtYml0IG51bWJlciBpbiBlaXRoZXIg
YmlnLSBvciBsaXR0bGUtZW5kaWFuCj4gPiArICBmb3JtYXQgYW5kIHJldHVybnMgdGhlIGVxdWl2
YWxlbnQgbnVtYmVyIHdpdGggdGhlIHNhbWUgYml0IHdpZHRoIGJ1dAo+ID4gKyAgb3Bwb3NpdGUg
ZW5kaWFubmVzcy4KPiA+Cj4gPiAgUmVnaXN0ZXJzIGFuZCBjYWxsaW5nIGNvbnZlbnRpb24KPiA+
ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vc3BoaW54L3JlcXVpcmVtZW50cy50eHQgYi9Eb2N1bWVudGF0aW9uL3NwaGlueC9y
ZXF1aXJlbWVudHMudHh0Cj4gPiBpbmRleCAzMzViNTNkZjM1ZTIuLjk0NzljNWMyZTMzOCAxMDA2
NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vc3BoaW54L3JlcXVpcmVtZW50cy50eHQKPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vc3BoaW54L3JlcXVpcmVtZW50cy50eHQKPiA+IEBAIC0xLDMgKzEs
MyBAQAo+ID4gICMgamluamEyPj0zLjEgaXMgbm90IGNvbXBhdGlibGUgd2l0aCBTcGhpbng8NC4w
Cj4gPiAgamluamEyPDMuMQo+ID4gLVNwaGlueD09Mi40LjQKPiA+ICtTcGhpbng9PTcuMS4xCj4K
PiBJIGRvbid0IHRoaW5rIHdlIGNhbiB1bmlsYXRlcmFsbHkgdXBkYXRlIHRoZSB3aG9sZSBrZXJu
ZWwgZG9jcyB0cmVlIHRvCj4gcmVxdWlyZSBhIG5ldyB2ZXJzaW9uIG9mIFNwaGlueCBsaWtlIHRo
aXMuIENvdWxkIHlvdSBwbGVhc2UgY2xhcmlmeSB3aHkKPiB5b3UgbmVlZGVkIHRvIHVwZGF0ZSBp
dD8gV2FzIGl0IGZvciB0aGUgdGFibGVzIG9yIHNvbWV0aGluZz8KCkFuIGFic29sdXRlIGdpdCB0
eXBvIG9uIG15IHBhcnQuIEkgd2lsbCByZW1vdmUgaW4gdjIuCgpUaGFua3MgYWdhaW4gZm9yIHRo
ZSBmZWVkYmFjayEKV2lsbAoKCj4KPiA+IC0tCj4gPiAyLjQwLjEKPiA+Cj4gPiAtLQo+ID4gQnBm
IG1haWxpbmcgbGlzdAo+ID4gQnBmQGlldGYub3JnCj4gPiBodHRwczovL3d3dy5pZXRmLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2JwZgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0
dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

