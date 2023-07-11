Return-Path: <bpf+bounces-4764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE55174F11B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715932817ED
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2B119BB4;
	Tue, 11 Jul 2023 14:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294418C3E
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 14:04:25 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096E10FC
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:04:22 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 76066C151701
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689084262; bh=cvmM77Ip+PEWOj2eIDhC2DDOE6LqmyW2Q78fQ6wb9xY=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=U1WZAdt718NgItcM5GZfAaP5PS85/LvTnIxurvdyK/CvDUQAP5t4SFnN32lf9q3h8
	 9p9kMPv2quLi8SvW5zAgGbJgwccIHv2WG6uTjdq99sCRw/FUMWUTqBO/yzeQDRMR/F
	 uLl1XmNTDOc3eN5V1AlO7zHbCI6UEeQbvFqG5B6w=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jul 11 07:04:22 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3BF60C151090;
	Tue, 11 Jul 2023 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689084262; bh=cvmM77Ip+PEWOj2eIDhC2DDOE6LqmyW2Q78fQ6wb9xY=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=U1WZAdt718NgItcM5GZfAaP5PS85/LvTnIxurvdyK/CvDUQAP5t4SFnN32lf9q3h8
	 9p9kMPv2quLi8SvW5zAgGbJgwccIHv2WG6uTjdq99sCRw/FUMWUTqBO/yzeQDRMR/F
	 uLl1XmNTDOc3eN5V1AlO7zHbCI6UEeQbvFqG5B6w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E62B0C151090
 for <bpf@ietfa.amsl.com>; Tue, 11 Jul 2023 07:04:20 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.098
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gnu.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mPGm7WVoYIDt for <bpf@ietfa.amsl.com>;
 Tue, 11 Jul 2023 07:04:17 -0700 (PDT)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 10C08C15106A
 for <bpf@ietf.org>; Tue, 11 Jul 2023 07:04:16 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemarch@gnu.org>)
 id 1qJDyQ-00006L-GR; Tue, 11 Jul 2023 10:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=NpaSxipqmX9poXsWhpR4q+yVnkTQK1VtwmJHQsc4V+4=; b=kDM2+rc6xNCwgr3roFyT
 PMNMjRFLZmusqaYHjXxSGSz++Umfqnx7TkydDsvYFqd+uoEJn0qxk1al/MDPg5+SOBlua9iU9rqs4
 WYW04kpTVkdQy7afgsuwyF4ofHnT3hFvF1/FClLSQ6eCipy0Lm8MmubqxeckAFVuAoVWBGjqnoAn7
 4L836Xd8jtNP7HeOMhL+A5xyN4LEXZUm49z9w1auWcKAX7Vwq57AZKreSw2UxAMC5y0OguEFgehxd
 tgMtDQo8IVZZdFKQYKXc8FuH5IJXLOu0WGEL/TdeMsKS2K2NJT29+AB43TgXzcuCOnzDA/+Fn9aF1
 wHKsaiwD0Dh6fg==;
Received: from [141.143.193.69] (helo=termi)
 by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemarch@gnu.org>)
 id 1qJDyQ-0000RG-4q; Tue, 11 Jul 2023 10:04:14 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Will Hawkins <hawkinsw@obs.cr>,  bpf <bpf@vger.kernel.org>,  bpf@ietf.org
In-Reply-To: <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
 (Alexei Starovoitov's message of "Mon, 10 Jul 2023 20:00:31 -0700")
References: <20230710215819.723550-1-hawkinsw@obs.cr>
 <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
Date: Tue, 11 Jul 2023 16:04:11 +0200
Message-ID: <871qhe7des.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/evzH_PJcUv48xDRRC0wtxf1zuWw>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
 docs: Specify twos complement as format for signed integers
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

Cj4gT24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMjo1OOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2lu
c3dAb2JzLmNyPiB3cm90ZToKPj4KPj4gSW4gdGhlIGRvY3VtZW50YXRpb24gb2YgdGhlIGVCUEYg
SVNBIGl0IGlzIHVuc3BlY2lmaWVkIGhvdyBpbnRlZ2VycyBhcmUKPj4gcmVwcmVzZW50ZWQuIFNw
ZWNpZnkgdGhhdCB0d29zIGNvbXBsZW1lbnQgaXMgdXNlZC4KPj4KPj4gU2lnbmVkLW9mZi1ieTog
V2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+Cj4+IC0tLQo+PiAgRG9jdW1lbnRhdGlvbi9i
cGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdCB8IDUgKysrKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0
aW9uLXNldC5yc3QgYi9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4+IGlu
ZGV4IDc1MWU2NTc5NzNmMC4uNjNkZmNiYTVlYjlhIDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vYnBmL2lu
c3RydWN0aW9uLXNldC5yc3QKPj4gQEAgLTE3Myw2ICsxNzMsMTEgQEAgQlBGX0FSU0ggIDB4YzAg
ICBzaWduIGV4dGVuZGluZyBkc3QgPj49IChzcmMgJiBtYXNrKQo+PiAgQlBGX0VORCAgIDB4ZDAg
ICBieXRlIHN3YXAgb3BlcmF0aW9ucyAoc2VlIGBCeXRlIHN3YXAgaW5zdHJ1Y3Rpb25zYF8gYmVs
b3cpCj4+ICA9PT09PT09PSAgPT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4KPj4gK2VCUEYgc3VwcG9ydHMgMzItIGFuZCA2
NC1iaXQgc2lnbmVkIGFuZCB1bnNpZ25lZCBpbnRlZ2Vycy4gSXQgZG9lcwo+PiArbm90IHN1cHBv
cnQgZmxvYXRpbmctcG9pbnQgZGF0YSB0eXBlcy4gQWxsIHNpZ25lZCBpbnRlZ2VycyBhcmUgcmVw
cmVzZW50ZWQgaW4KPj4gK3R3b3MtY29tcGxlbWVudCBmb3JtYXQgd2hlcmUgdGhlIHNpZ24gYml0
IGlzIHN0b3JlZCBpbiB0aGUgbW9zdC1zaWduaWZpY2FudAo+PiArYml0Lgo+Cj4gQ291bGQgeW91
IHBvaW50IHRvIGFub3RoZXIgSVNBIGRvY3VtZW50IChsaWtlIHg4NiwgYXJtLCAuLi4pIHRoYXQK
PiB0YWxrcyBhYm91dCBzaWduZWQgYW5kIHVuc2lnbmVkIGludGVnZXJzPwoKQUZBSUsgdGhlIG9u
bHkgc2lnbmVkbmVzcyBlbmNvZGluZyBhc3BlY3QgdGhhdCBpcyBhbHdheXMgZm91bmQgaW4gSVNB
CnNwZWNpZmljYXRpb25zIGFuZCBzaG91bGQgYmUgc3BlY2lmaWVkIGlzIGhvdyBudW1lcmljYWwg
aW1tZWRpYXRlcyBhcmUKZW5jb2RlZCBpbiBzdG9yZWQgaW5zdHJ1Y3Rpb25zLgoKQnV0IHRoYXQg
aGFzIG5vdGhpbmcgdG8gZG8gd2l0aCAiZGF0YSB0eXBlcyIuCgotLSAKQnBmIG1haWxpbmcgbGlz
dApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

