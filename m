Return-Path: <bpf+bounces-26723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6958A4216
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 13:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D32A281E10
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE428376E6;
	Sun, 14 Apr 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QA0Q6OEN"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244741A85;
	Sun, 14 Apr 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095132; cv=none; b=QTIkVL4pVr5GJrQuIcKTN97bVT2VNgKpCAriNvwmn43TvKKgpgMIPpPOe3Fs4c2TmRMWHLEIV0+rRc3r0+uC7pXOEtgP476g4bvuROk4jCU5HvHCeoh8lHE0OpcZZtNY5EvOd1i0Xit+ceSVrp9ujdlbbDhaQAiI//naQmnVPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095132; c=relaxed/simple;
	bh=U0tpeTPOyTpPTe351qE8OA5AoJGCat0VCds9PVfXYDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MrKXYn+F/lcoIuhvk3pfyGWZJiYvq8wtIiXxGY+5rHl8u4WyS7E/fBZ1wLPa26lyH20eNDgUsZTWYITNhvXfsIzlj++XXhPQi0Fh6VZUjun8CdTX44DlYzuLnsRFKPoCIIMXJ7vr68xsC7noEcB2ZR5pWTurfQnolgPvhyF01wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QA0Q6OEN; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713095030; x=1713699830; i=markus.elfring@web.de;
	bh=U0tpeTPOyTpPTe351qE8OA5AoJGCat0VCds9PVfXYDQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QA0Q6OENUATU/abBO9zX2wIvluDcY8NFt4xBXbtZugnY4jdbgCebbMel1audTVCX
	 PQ9qKQY/HOgzZqSWHpcSvNV/yoKEd0dXQfGyN4vnAk4GqzUAa/iC1prBpCexNK9m9
	 CrcnUY73IR6viruwjyDvtFPLwteyfZ8GuO0gjgG5CXzMda9v+UCbgTDwzysZq4ewD
	 lnX6KiK9XjYuBUaDgAjX/Kk0AybuZWPVA3CcDhqPkRdA7/46/9C73SMHMloH2ukh+
	 CEbAlyjAHVvSx2mu+H3gmHPoiKSdWe6QRDLvMvIGjJmGsjhmVE2wS3uD+duvg2a3z
	 XTQm447GhtcL3C+uSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDdyH-1s55LF0CKV-00ATJ7; Sun, 14
 Apr 2024 13:43:50 +0200
Message-ID: <af56a3c3-d144-4d90-9f1e-c13a4122f8a7@web.de>
Date: Sun, 14 Apr 2024 13:43:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] perf dso: Reference counting related fixes
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Colin Ian King <colin.i.king@gmail.com>, Leo Yan <leo.yan@linux.dev>,
 Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Anne Macedo <retpolanne@posteo.net>, Changbin Du <changbin.du@huawei.com>,
 Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>,
 Paran Lee <p4ranlee@gmail.com>, Yang Jihong <yangjihong1@huawei.com>,
 Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240410064214.2755936-1-irogers@google.com>
 <20240410064214.2755936-12-irogers@google.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240410064214.2755936-12-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mKDPIQbEDcmb5BrKUYjJr3Qfc9P8lnxxMTPWzBhrGyLcPxvCb4u
 dM8KAmhNo2HfYqk8DC+kHNx0slCaXqPBfha3rzlz82HUrwjIRdpI2KUvXM9N1TkyfBmDnZ3
 7Pv5rYszyANAaMh1el0nH4fiOdX6ZF4Ve9D3SxShf07LS+6d3qlEWu9B1y67l+s8KRv6vGn
 9p63EFqc0tr8lXDapVFFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8YTKCMYD3Sk=;yyymS+m1aex9L1SSrYC77ZiqZYT
 eqn7cbY+q3rw2pwdWaOvOStqkH1TCq2wzjIkRmRluUdQC6/tdYpNsH9rA9IxharfsfAOjSF08
 d2BthLti8KnaPwZfCE71v8QBsLM2R4iIzIURMNkaFUAUwzJ9+Wu9ZhX6fTphjntmj4LATB0xA
 NTlm/60G+DHNHLNigj3q91XL4jCFjVgD+AITqU8PvWuJP1k5seUuokzT12ALS+XNodq2BWxvg
 pJKLukd66zp5cokTe5cCLRjQVcXdUNnsjkVhTzOAmRDOv5xTkMt0tSOI7SltYpMITOLaqmBhB
 ANt8BYht2rbRmRSCd4+G2Sx28u2f/RUnYK+gHOu0L+3IZT/hZoMkECgW1l+bQwlXmKY1oYcS8
 6YjBbr2xJNNau+Yitb2ttCfhpdyYibtDxW2hkNXf5/buOjDEUkzRQOpcl9Thb/wniQ23yxuzv
 9UOMWCIcTxICFpq9PgcmofqcJ6P4zTX8JgebxTqC4uBNlNP4gIWXRtHR1+ld5iVEVr0p9dEyY
 yKb7IMDMEUAhScIX34pYw5uwF2ZLzVhE/PbhlxvhwAlCdENd92u+Sfi7tT8OMV3LJbXXrROx5
 Liz+jtdw1978LlDhavIs7gJhl6QwhW6HHhLWVbbyz15nuYh/322JYJvfWv68Fjf+zx8vq6mlN
 hlVc33CuzyqXUx3DmTween7BxzJsLCNgOnmPRBmzyKoUveUlyximPIA98y5eu5mbcJTkYgrl8
 IRSjb5D8G1NBuvTmNb+QqQ9pfCTz3JHHOWBr7ZjagCw8ZTYu7dc42vBvKkUm52YspCPK1xvDC
 Jt2gKxZhc4x9oSnIIh+o823SzsXbzAB3H8phvSyb94p9E=

> Ensure gets and puts are better aligned fixing reference couting

How do you think about to avoid a typo in the last word of this text line
for the final commit?


> checking problems.


Regards,
Markus

