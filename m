Return-Path: <bpf+bounces-47684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56D9FDAFF
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705EF162255
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C518A956;
	Sat, 28 Dec 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kFwOvwp5"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70BA4D8C8;
	Sat, 28 Dec 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735397303; cv=none; b=FQklRc2IDffvB3Oa6MKaswxdgbAoDfWmab80AVTLk63/PLeU1HU+OOIBqyji83+RHvdub6N77hVvPwn71EPAGiF2nXhVhYM//09/kO4qUm+aIYsD5zFkHEX+VOxXo/7MDBQcpFTqocy3mI6qWDAqDn0/E6KoYe4jyPWF2ub3pkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735397303; c=relaxed/simple;
	bh=V9Xf5dQCY2um4+iby1cyctrdcn21UwiCo/Bz8PDcUJw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bS/iRVJx3PWkFjJefgWnRXDbb6LGBXTlGd/Fp8pO/9pPOzHS3JbiKCOft578i7yTMqUo4wXtXEUIukqfKGlzoYkuiCPPIUfFW8+/fL1s/mQA3l07aIgSoQCs8+rOJZShP7t7icaIE2eBmnxL1mKQbEc3MijHSevmwPPfV9EcVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kFwOvwp5; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735397290; x=1736002090; i=markus.elfring@web.de;
	bh=V9Xf5dQCY2um4+iby1cyctrdcn21UwiCo/Bz8PDcUJw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kFwOvwp5IYVl11AcFxEOI6CgXbGpXSjgmED5IIKaCt6AEzDfOpYnzRWn7rskNFOQ
	 JtF8E3mFPlseuqtY3LFxwUf0/9JnbskTNGquu064DYa6yRqnwV3NzpWPxrwJFk7vZ
	 k3FZtDNxuKB3aNlpn5opRpX+SQAh5lMnQmbW2SBgEWkjgZEupNAJjX3M5BXjAsVc2
	 zxJ8/xJfHWzxzoDiLDOwYGQtpuLY51YCusZc0D0W6U6ImbRlmPa2ejViSD0JoPnfl
	 WPva2E3GZf1vR3cS8wCJrMmyAA6Jdhia1SqcRIz+6NBxGJAGQRcER/mk/+tCCOaO2
	 j6jU3LqD6D5VuGiQSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.40]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnG2Q-1ttDLh3LE4-00qZpk; Sat, 28
 Dec 2024 15:48:09 +0100
Message-ID: <33a2b169-150b-4015-abce-791da3d1c32b@web.de>
Date: Sat, 28 Dec 2024 15:48:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241227151403.121602937@goodmis.org>
Subject: Re: [for-next][PATCH 15/18] selftests: ftrace: Remove obsolate
 maxactive syntax check
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241227151403.121602937@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Y/VZvamizXakc1dyqCoWHqO/CeCIhhBmnwsDBTf/xuXH50NcZXO
 rlreKJQ4oerAXBWws+DajQIu+rpLdlb/OXfUzRjowos+4AMhCSdcDuZqhprfsRYnwIlvLku
 n95lNT+JolvAG8ItvlgJS+c27/HEIy6exNX07JlnlHpGj5RWPPtGeDbIBD+S4l/IvG2Pxcy
 z93pdf+BgkHvY83lCdyAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TeL20CtBgOc=;2UJX3JnW6BxS2G2jN375RxrbRjU
 4LI185gUFJ0s0lZYCyAdmiVJUdYdbMJlzfBOJji+aAFdNrfmr0HlYpY0ELQnAbXzHxrvXd9er
 WWsfMr4f4peLpHGtxPks6fKkA9+FDV+Xf52np0NnoyqqVqO4qxXpDQDvtSfONWBnmTY9tzvlF
 c19S/WL6Z7Z/xI9c/lWW3y+LkN1hUij7+C+JTiFaZZQ9jUUFQjVt2f/ug8hXzwi67YLWoOy4e
 hAvPvCF8V6uZE0OFdZRpHU57/vceMslT8s47N1fMKgG5HLTKTo2X36iApKXQ5eQLw48O8aW7k
 V1kiZ90Dmh2tSeLNdMo9axqO3jj9dggRdOsQenFfe5K3LwN7Z6JgPWCcbkS0wTgtCrixHoHCd
 XsWSTBqXJ46hFqaH6oKD0ye8SnS7Wfx1HiZKg7BVaeJ4zcS2siGMKiYbHcS5nvkIH4qocKgm3
 OO7oh07VSdXFd9/FOLoXk4xPt3zfrIAUiBCyODbVdcsZE6+iVgMdjIlCOFkD4DIO6i0hhv52L
 ASlFq9jVd+oxHIgnhW7Avm7F5/BkAlmF1vPnrGgAaZblQAcRSveiP2ShNgn2BJaOdtFgJ1ipq
 xmD6YeTThx9+x2aC8ctF40UDK7KNxOBF0kZtOa9RRYZt/lQYSOrGFUP8FrTAtr1QJovtMEibf
 8vmB394oAMgu1VOlRHq7ZuRXF5xxGS0llg9WBiZWnRrfMXcXsbVWiM5k2pq96RG7N7tnt0gtP
 21YMbYxWxMlmM/gPuOCGCWp5wT5wc4CCP2kKIhrZcpWWBwrliGlq1qRCjYol366XzT3GeGg9H
 NVw2RBP8F0ujko2hWlGexCoubiha9VTYYtONUBdcm3pty90db4P1wgIar5tpAP6XtG1LRhp2h
 5gXVlBpjDCnyGKeyQeCbTqgUV5PJnryDpLftcAYaMyKHnDyzwcupqgmpU8f9f/ZaCptIm9Y/w
 HIlKuxBgdWK19TO0ozYeIfPihwSvboTJDn1Rga/kkuMAQnlV5ysfW/oSe418bLEumRuLxtxaO
 G5bP+fSB0jS/GgqmfOApMtw0IyGDFW9tKQnkSMxTRVK3yUlj/K17NCsWGqmtyIlD0/d1a3LlX
 ZxOZRemHc=

> Since the fprobe event does not support maxactive anymore, stop
> testing the maxactive syntax error checking.

Please avoid a typo in the summary phrase.

Regards,
Markus

