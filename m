Return-Path: <bpf+bounces-43821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D819BA330
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 01:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DB1C20F48
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 00:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB433D8;
	Sun,  3 Nov 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OAho+pny";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PjDOegJn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DF2572;
	Sun,  3 Nov 2024 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730592503; cv=fail; b=bg9LSsnBDKv/RxGzreSLBq/2q0sa/s2MWQ4lpavM7D+MH3JhS1IbXYwxcfpxu35eHjrKqniZEkqL1fX7Y4O3r/VS2glX4fVEVbLw0LQvEUXgEnu4aoQMwI/95ilS2/1sj2RSmUXgeubx8OQn25wx7F5y0bCDhGhlNnMQu1xa+N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730592503; c=relaxed/simple;
	bh=Jtqx5qhWR5aDYm6+FEkZ9jmzuJzaJ8a8TU5G1k1CL9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2YCEzHRnmQ0XFu1XHF5CCfIqNP9vi657oe1Gocc9Tacyln1Z/bGLexFj6ugt5fQfiH9dMIa5lIOhWVCcpbn/NgfLaZb/cdjbxyvzLquvpniHImAeUCMoT5AoSBnzeazhb92xHrHKiQE51YF7kbfjZFmmVCQABHz+YGadEd2n3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OAho+pny; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PjDOegJn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2Nowqm011807;
	Sun, 3 Nov 2024 00:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TapYvCZZaK5d3q2vKojBtovJrOyejlVUi7EduMo2l90=; b=
	OAho+pnygzcL2GEaAzWMv09wjEZuoIgEZ9BL2BVN4EYrkFkxJoKXnTil1vhVOofy
	xFsEqIEJXtVB6lLoqQm3rZZern9+X7th+uRP6GHfb9lEOR/rjrpKXWETq5C7FJ0R
	jHvpAp5RbuBO0N0niwmdBFcGWCtD86zMzljE9TysKMJg7hWyz/xs1vW/k87eqgXW
	wOskusi2xGdJE9eLL45BWoSxICxnXMZkF68g5CAuIfVYsUvKIUQhEwN3xwVbtpVu
	oc/ov4UWI5uQ/vHspLayaxIC5FEEeIkm1qVL+jrrj40d9Pg7ypZr1IoOfpv6A2n6
	5ndULfLCYHR87rdchQSLRw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nby8rndy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Nov 2024 00:07:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2IbAJQ031437;
	Sun, 3 Nov 2024 00:07:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah498vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Nov 2024 00:07:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljnwKDbfJizYPRmwk9swgPNr+iFH9vp8QCqXuHdKrOGyOCKjI1B1YvJk5NudE+4xZDlg0J1lmAFCMNFotI+g8inll7kt1rHm8xZk6lNKcLC1SJrOX7X6w2DMdFMWkKSsTRO58WawtIPI6JDuDbrcDrbEh07jFV+UYU+AbBNO7wSsl+JOiRdUpwaHd2qZ/5jQsQbiGHNNyaHtQ3qRmfYi4IZm5Xudc7A1xlYJrddpauKCM1CR+SQRnQZmGwtXcTg5s3tsa4s+MhQKcvyjWmZYT7mheT9cbIeDuizZEKbCDlyqdrwmw2p5h6IqXR5UnisrF7+6TQUEYl9CI4hXYBFaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TapYvCZZaK5d3q2vKojBtovJrOyejlVUi7EduMo2l90=;
 b=PPtfoxXy7KjsgrMH3uP6XFKS/wn0uCEsMN7b1dKJkbBxpebf8iUj4UOmKgDxOpFYebLCvxbTlN/qLKuqrCYIc7WfYe0Sn+LbWAcY6FHmifpdCZIuRLUps/0/BnEcZmz7QkGupd/IAnTwlIoc1k1pB96JRXeeTBMbS+llQpoPU56DNJ9FViVJSbXneFpnegbCZqJKVLR7Mkf0EVC5NsJfhirmrAgDwaVMMgfNgpwsCYeb+0Oyi6/bocyqtIYEt52Ph8//vH/a6+aLvFyXXX61ZGiBUZmnRzYk18ZFwSssmL3HrgFVs46WZQA7vmFogdRlzGVkr+SINru6hs4RwZ/aLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TapYvCZZaK5d3q2vKojBtovJrOyejlVUi7EduMo2l90=;
 b=PjDOegJnNYDQniF6IRZjYgvxsd4tk/N54k9cJ6X+hlkqdaszMLa0IOMTVU641ozaKjLjVloT2WvQxDAUuVtnidbCAF8PTFkLAGUevMPo5BJVNzHI9qTmYEClMXc+AEhnrRhlrPIqb8rQs9vy3fwseGmU9vrXC/6jgHRH8Mzi9/s=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Sun, 3 Nov
 2024 00:07:43 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%3]) with mapi id 15.20.8114.015; Sun, 3 Nov 2024
 00:07:42 +0000
Message-ID: <12e58016-e3f8-4286-bd1b-99b789955301@oracle.com>
Date: Sat, 2 Nov 2024 17:07:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
 <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <0f40b9b8-53a9-4b45-883b-d4d5ecf9fff6@oracle.com>
 <CAEf4BzbLt3b8xH3eSvRJdnorZvQfWzOFeV-gYRxDmaS6YVba2A@mail.gmail.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <CAEf4BzbLt3b8xH3eSvRJdnorZvQfWzOFeV-gYRxDmaS6YVba2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|BL3PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 5451ed7b-6210-4125-67f2-08dcfb9b8993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTBTUVZDUGkzUmM2NEcxcmNjU3ZVaER1QUhTdVlPMm1CNTJWb0M2eHBveWVB?=
 =?utf-8?B?ZlpKTHA5aUJ0RXFRemhaU2VReEpCTnJzZGRPTWlURjRVUzdSbmMxUVBLZkNn?=
 =?utf-8?B?SXpiVG56TVNWeGRDVm5SR1lEeGM0cWNwMU0wOUdPNDZualhwWS9nSDRKdmln?=
 =?utf-8?B?WE1RQUd3VWdWRzBBMXNVR1Y0MHdpNHJ2Z2xpVUtOOGk4NXdybGVQS1cySERF?=
 =?utf-8?B?d1pDQXFmVkdlR1FYbm5aczRwUUdlSi9yT29XTG9vSmFQWkV4RTJGcUNUZnEy?=
 =?utf-8?B?dzVLR0taeVJCR0tybGdrSUVmdzRKQnB3QnBIWG9pQnh0czUvKzFjZHBBdnhV?=
 =?utf-8?B?N2tCQjRtN2dmUzNqWXIzRis4RVh0UU5RUzl4T29iTmxxWlZCTFZvc3dTMk5m?=
 =?utf-8?B?by9qMitrbCttNkl2TDZSUFBHenVDcHRvdFlaTHB2MGdNaTZBZ3FQdnprTVZv?=
 =?utf-8?B?MWNJTlhuZjVzdWVZK3NYbldMK0VybjV5dU43elhZZkhKY25WYU1pZll3ZWhG?=
 =?utf-8?B?QTBocVR5Ujh2b1pJekdWZzdzZHJRdTRRWmd5c2k2cnk1Nnp4T09YOE9QVVhw?=
 =?utf-8?B?QVJCYnZFM0RCQWs0T3dXRm55MDY5Z3Jzd2FOL3RkTzF4dkpuZTF1eGZBbEx5?=
 =?utf-8?B?V1FRTXRUclhkYVNMU2RPazZySXlDNUVQSHpwajJBWE5NTnRnTjRPbnpISDd2?=
 =?utf-8?B?eHExZlJ1c2Y1Z1N3MVBSYUQ5NkZYYisxbE1NYVd3T29SM1dmQUpvVFUyZ3Y3?=
 =?utf-8?B?MWV2a1RYSGJqQnRFMXdZTFZFTXVMZjJkOGRmaUZxdVJ1dHgyM0ZUMFhmcXlO?=
 =?utf-8?B?RTJzYWhhWVB1d1g0VHVkMFI0OVdKNThiQllPM1huZjRTTWhrWmdKeVE1dWVx?=
 =?utf-8?B?bmJQL09NVmZxWjlibzJzVG9NVGtMT0tjbThNcFVMUi8xNHpBcldNZG9BakU2?=
 =?utf-8?B?eUFHbWttNjBWMFcyd2RJcGpWKzFSSmFUWm5RZ1JLQ0NjWDNxL1FOSXFOeVFm?=
 =?utf-8?B?d3BhTGUyR2FMdXF0TGRIb2gxMlk4Ri9ZTUNERFFzTU5ITlJDY1ROaDE1VWlt?=
 =?utf-8?B?aGJhR2ZBYkN0bGdDaUxFYU9vMHZQcjd0NDBYaGxBL0YxVytFU0tzOGxTYm5D?=
 =?utf-8?B?WHU5TURLRXp2RHFXQU14NXZ6TDNmTzZ5WlZJbldlSnVldzVWUE1XYnNZaW1D?=
 =?utf-8?B?UU9SeXVSOTNGTFVubjNZcUVQc3I0di9hK3hSbU9TRUhDVm1ESU9HZE4vL0RV?=
 =?utf-8?B?cEQwbXBHL3BvZXBzYmIwbjRZVllkWnFqOC8zZDcxUnk1OG9QKzlYeFNSQWU5?=
 =?utf-8?B?b3pLVCtrYWFuSFVpZlNKMmJIME5Zc3N5aS9FRWEycmxLUGVPcXp6dlpVVkF0?=
 =?utf-8?B?NWRxaVk2MXR5YjNqdXB6WFcrSDQreVNLbTArY2VXQytab1dxc1RBdk9wUDBu?=
 =?utf-8?B?R2paRkRFOGFUVnlRUWdMeTRuMWdKUjRkdHhFQy9RZE51WkREc1VsdHhTYUsy?=
 =?utf-8?B?MGdJZ0dmNXNUeW1xbXQyK3VmdktjeUdPUnJOR2VQVlRQT1VUaFFBaUxIaXNm?=
 =?utf-8?B?ZndJTkxTL282VTFrMDM5OXJIZFVRZGZJeFgxYU1CS2VTRENtTXMrbFYwTGpt?=
 =?utf-8?B?S1Y1M0F4c0xkZTJvdnA1SDEzanBvUzFvUjB1TldPRTVBOWU1NkhYSE1FOC9N?=
 =?utf-8?B?ZHNPZVMzajdhUmZmdUN1aDQrc2RkQnlZL0I3eWx5NHFZaVBHVWFSN0RFS0xM?=
 =?utf-8?Q?EBxCeoos0EUZ7b7pP5/XHtcPoWXXl1LB4DaTqET?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWVVK0ZCVzBJU29GOFRnaHkyYnZ1UjFERnR2OHh2ZUJvdld4M3RmaFNLMGtw?=
 =?utf-8?B?WXhUWTRyK2tYN3FFdEY3bDVuMEIwcmhFaWl6aEhZTXFjNUxsRHZSUU5pMzhT?=
 =?utf-8?B?a2prcHpuOEx6ZXVZYTd6VjJvb1l4QWFPKzBBOTJ5TTNGTE85YmZ2dENqQS9X?=
 =?utf-8?B?T0VGcHl2QUMwSHorSkUwb3p4YkVqRzhHYUhUcytmUXBzSFFQYnVwYWk5Ui9R?=
 =?utf-8?B?V2lNM2lpYktoMU1EcG9JenMwRWN5L2YwZ0xSY0RtaFJ1WVdWbDFYZ0lFamNk?=
 =?utf-8?B?VjFoYksxcWRSQ0IwNHZYcnViVWhvMWJ0a0dZclR3VnJoVTZaa3dncW44L2Ru?=
 =?utf-8?B?YTBTNjJMLzF1SzBmK282S2oyeVJjZXNoak5HZXg1Z0c0T2ZZYmJsTlhUOGs0?=
 =?utf-8?B?N2h2T2FwUXY0Uys0VzRXSlVJcHNLWWNubUNta2t3V3RrTGZvWFlndk1KdXo3?=
 =?utf-8?B?bXdRbVhLYXhpcXdsbjVqRHJkVVViTEtldkZ5SFVlNDMwVDVLeWx4b3M5SGsv?=
 =?utf-8?B?cmxWNXhsZ2ZwT0FNVFNJY25JNVcwSlpscktkV2dtVklCRzdMTlQ4c3lBWDNj?=
 =?utf-8?B?czI2QlBMSkpSTjNjQXYxU0VPNHRUL3I3aWZEOVlDckhVaklpc254NXUybVBL?=
 =?utf-8?B?Zm9VVmsxU3hBNXQweWdWUGNDTFJ4dU5FSkM3dnNpK1oyUFhJU29qazlLZnU3?=
 =?utf-8?B?YTJFdlkvRndEN0pYSDFEa3p6a0lIQWdXWUx3aVJEbFF0MVJTejUvUDNvTUZJ?=
 =?utf-8?B?TU1ZYXZYdS9qK1dRSXNuSlBqcnFocGZ4VW9PR0FXQUoyZm9VT245SkVOVFNO?=
 =?utf-8?B?SW5meDlZVzloYkxyM2J5bWRLdEFwNkdVLy9SWUFxeUlnR01PbHFPNTFDcWpT?=
 =?utf-8?B?YmozeFJ0SnVQTzBRaUlJSFJIckVQRUtSSjl4SHNzSElKNmdkTE5NM2g2WDcx?=
 =?utf-8?B?ZTV0ZHFnN0crS2JFMUY4UmNVejJxVCtQMXgzRHlrZStoSEVaOE90c3JFKzE2?=
 =?utf-8?B?Tmc5WTlPZkgxRjlMUXN1VGgrcjcwdy9JOGtsbzQ1OCtieG8zcjJvY2pRZnRq?=
 =?utf-8?B?RExibkFmbG8yaURNQTc3Q2l5TDEvMUdiYk1qN3BTWGR3NlBncEY0Sm0zZkdi?=
 =?utf-8?B?SkZzM3JhRTAwaTNENHE2OTRCU1dGRzVaMnp1NU1YcHFVa2JqbUs3TE5Bb1Ew?=
 =?utf-8?B?NE5wTkNYamVKdEJndk9wdGlOemxCS2RTRG5EbHg3SHJ0Y1pIQWNEVzZjUmJh?=
 =?utf-8?B?WVpSbFRZSHcremhVU3VFdXFVcUV3R0VrblYraFcramVMVi9pMmw2RG4vYlcw?=
 =?utf-8?B?djFVNUxFK2RGOGhyenk2Qi96S2xUdkkyOHNya0x4VVRudWtlVWxaUm5xeGNN?=
 =?utf-8?B?MUsrd2FBYi9aWEhXUi9sTEx0cEM0ZTdWVmpuQ2JSWkpubWIxSkJHSEU0NitP?=
 =?utf-8?B?Q3JPbXlpNUF4bFpEVFN6TmdvUXBiMzdJMDRTa1oyNndESTcyRWFvQmZpdDNE?=
 =?utf-8?B?NnY4WVpweTBZUzMybUptVnZWQ1QxTWZ3eVJsOWhNRUFiaUUvTHpGQncxUnBK?=
 =?utf-8?B?b3NpOUFGS21TTSt2cWZnbXNYUHM4Y1Z6R2FoV2d4VG5lSzJZaFhwZHhnQ1Ar?=
 =?utf-8?B?WExrMnhWempyL1dlQW1hRWQrK3lKSGw4cXk5RFBvdkxaQ2NickNQWHhTUnlv?=
 =?utf-8?B?Kzg0K3FLbGpZT0l4MDRielFBUnI5QmFZcGxlWll1SldkdXJ3dUlsQXdSL0Q3?=
 =?utf-8?B?eXpUbjQ4dURjM3FCR1UreGo4VlRqWVFLN3ZYQUZMRmQyR044TUxnV2c5RG5v?=
 =?utf-8?B?enEyeGg0b3VuN0FwWllvdmxrOWllQXp6bW1iNmgwVWdFQWZ4Z3ZoL3grdm4r?=
 =?utf-8?B?bkFMZFlIVDV0MlMrTXEyOXNLbUJLUHArOFdWL0JYclNNMnVWY1hWdEcrSHJQ?=
 =?utf-8?B?ak1yRGpPMFczeW9tdlVzd1AwbWYrV3EyS2dMdm1lalVrWWhHckNiSVJGMXY0?=
 =?utf-8?B?alh0S2Ewbm1Xalo0cDRWd2NpdERJVks4T0MvRW9heVRVS25NMzlURUpQMk9n?=
 =?utf-8?B?YS9ZdFBXOVlnazAxVitJSytOVWRNRXhvd1B0MWJGalVNNmVwOVNOUlJVSGlN?=
 =?utf-8?B?WGNMTkhob1JmajNLVGFIbXVXSSsxbE0xaWZheHM5dnNSWGVlMTJIenF5NWQ1?=
 =?utf-8?Q?fUPG9302OIabs/+Q2xFhqQc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yCYsKKOiHrv26RZBw5PqCXmfdKO4Kg3QT9k/pUI4ygT/EfK1rFdbSORH8DHqBMwwKt3q0R2wb9u58jqgm7Why+9QuLKtA9FEFzql6Q5Ujsa/6DCbcM6A+4r3DqTR6XcLPbPgKQY5b1ZTtuMYC7HtNzSNmcdiH6jKV1GsHrhA/mfWKNLjhsVHwCOa/pCrO8uiyny/726d+9qPRKk0eyU/WCchAI0wgj7iaC4wi3RYUMeVRJlbMYNKJ7/30uHwKYZArCv6gyYJnzZOIXV2Eh8Lykyj72Mi124OjV0EvJirqoOB80q6U7wv54cJTIVUSrd9zHkmUIaHE/aJ57N8N7GUy3gLgY9OHEoLBlUlQAd1BeVglfrevW+Bu7TNl8luGjEIhOKQFnE78q9QQ1z5miz05Uu4u7S4mKUlLShz7jonOImGkP5NY/glYOkr6MImySndnOa7AuRQa2KhMDZlDZ6W2M/3/956CjsZD1Lheu8hsSc1P2AtYSdz7HTGOQSFpIEJ4ugoP0XYjw3aqwt5VgZqhHDRdFaWgjmfOL+hsnuRuwCuqyntA/49/zZdI1KpFNE1yxgkPVbiqBO9jg4CWXn53Wl760Y3d9/GpQz5appGka0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5451ed7b-6210-4125-67f2-08dcfb9b8993
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 00:07:42.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6I5QGavgek+RNt6mrgM4gEikr5OTOO3EjPeUVTLqULM7fvOKloz1OcNBTE0Yw3CygdOE6tH9db18J+rgVWGYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_22,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411020216
X-Proofpoint-ORIG-GUID: 9EJaqPCCLKYEyXtHJxFO0MqE8rGvksDF
X-Proofpoint-GUID: 9EJaqPCCLKYEyXtHJxFO0MqE8rGvksDF

On 11/1/24 11:38 AM, Andrii Nakryiko wrote:
> On Thu, Oct 31, 2024 at 2:38 PM Indu Bhagat <indu.bhagat@oracle.com> wrote:
>>
>> On 10/31/24 1:57 PM, Andrii Nakryiko wrote:
>>> On Tue, Oct 29, 2024 at 10:53 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>>>
>>>> On Tue, Oct 29, 2024 at 04:32:40PM -0700, Andrii Nakryiko wrote:
>>>>> It feels like this patch is trying to do too much. There is both new
>>>>> UAPI introduction, and SFrame format definition, and unwinder
>>>>> integration, etc, etc. Do you think it can be split further into more
>>>>> focused smaller patches?
>>>>
>>>> True, let me see if I can split it up.
>>>>
>>>>>> +
>>>>>> +                       if ((eppnt->p_flags & PF_X) && k < start_code)
>>>>>> +                               start_code = k;
>>>>>> +
>>>>>> +                       if ((eppnt->p_flags & PF_X) && k + eppnt->p_filesz > end_code)
>>>>>> +                               end_code = k + eppnt->p_filesz;
>>>>>> +                       break;
>>>>>> +               }
>>>>>> +               case PT_GNU_SFRAME:
>>>>>> +                       sframe_phdr = eppnt;
>>>>>
>>>>> if I understand correctly, there has to be only one sframe, is that
>>>>> right? Should we validate that?
>>>>
>>>> Yes, there shouldn't be more than one PT_GNU_SFRAME for the executable
>>>> itself.  I can validate that.
>>>>
>>>>>> +                       break;
>>>>>>                   }
>>>>>>           }
>>>>>>
>>>>>> +       if (sframe_phdr)
>>>>>> +               sframe_add_section(load_addr + sframe_phdr->p_vaddr,
>>>>>> +                                  start_code, end_code);
>>>>>> +
>>>>>
>>>>> no error checking?
>>>>
>>>> Good point.  I remember discussing this with some people at Cauldon/LPC,
>>>> I just forgot to do it!
>>>>
>>>> Right now it does all the validation at unwind, which could really slow
>>>> things down unnecessarily if the sframe isn't valid.
>>>>
>>>>>> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
>>>>>> +
>>>>>> +#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),
>>>>>> +
>>>>>> +extern void sframe_free_mm(struct mm_struct *mm);
>>>>>> +
>>>>>> +/* text_start, text_end, file_name are optional */
>>>>>
>>>>> what file_name? was that an extra argument that got removed?
>>>>
>>>> Indeed, that was for some old code.
>>>>
>>>>>>           case PR_RISCV_SET_ICACHE_FLUSH_CTX:
>>>>>>                   error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>>>>>>                   break;
>>>>>> +       case PR_ADD_SFRAME:
>>>>>> +               if (arg5)
>>>>>> +                       return -EINVAL;
>>>>>> +               error = sframe_add_section(arg2, arg3, arg4);
>>>>>
>>>>> wouldn't it be better to make this interface extendable from the get
>>>>> go? Instead of passing 3 arguments with fixed meaning, why not pass a
>>>>> pointer to an extendable binary struct like seems to be the trend
>>>>> nowadays with nicely extensible APIs. See [0] for one such example
>>>>> (specifically, struct procmap_query). Seems more prudent, as we'll
>>>>> most probably will be adding flags, options, extra information, etc)
>>>>>
>>>>>     [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-3-andrii@kernel.org/
>>>>
>>>> This ioctl interface was admittedly hacked together.  I was hoping
>>>> somebody would suggest something better :-)  I'll take a look.
>>>>
>>>>>> +static int find_fde(struct sframe_section *sec, unsigned long ip,
>>>>>> +                   struct sframe_fde *fde)
>>>>>> +{
>>>>>> +       struct sframe_fde __user *first, *last, *found = NULL;
>>>>>> +       u32 ip_off, func_off_low = 0, func_off_high = -1;
>>>>>> +
>>>>>> +       ip_off = ip - sec->sframe_addr;
>>>>>
>>>>> what if ip_off is larger than 4GB? ELF section can be bigger than 4GB, right?
>>>>
>>>> That's baked into sframe v2.
>>>
>>> I believe we do have large production binaries with more than 4GB of
>>> text, what are we going to do about them? It would be interesting to
>>> hear sframe people's opinion. Adding such a far-reaching new format in
>>> 2024 with these limitations is kind of sad. At the very least maybe we
>>> should allow some form of chaining sframe definitions to cover more
>>> than 4GB segments? Please CC relevant folks, I'm wondering what
>>> they're thinking about this.
>>>
>>
>> SFrame V2 does have that limitation. We can try to have 64-bit
>> representation for the 'ip' in the SFrame FDE and conditionalize it
>> somehow (say, with a flag in the header) so as to not bloat the majority
>> of applications.
> 
> Hi Indu,
> 
> I think that's prudent if we believe that SFrame is the solution here.
> See my reply to Josh. Real-world already approach 4GB limits, and
> things are not going to shrink in the years to come. So yeah, probably
> we need some adjustments to the format to at least allow 64-bit
> offsets (though trying to stick to 32-bit as much as possible, of
> course, if they work).
> 
> I'm not really familiar with the nuances of the format just yet, so
> can't really provide anything more useful at this point. What would be
> the sort of gold reference for Sframe format to familiarize myself
> thoroughly?
> 

There are some links on the SFrame wiki that can be helpful
https://sourceware.org/binutils/wiki/sframe

> BTW, I wanted to ask. Are there any plans to add SFrame support to
> Clang as well? It feels like without that there is no future for
> SFrame as a general-purpose solution for stack traces.
> 
>>
>>>>
>>>>> and also, does it mean that SFrame doesn't support executables with
>>>>> text bigger than 4GB?
>>>>
>>>> Yes, but is that a realistic concern?
>>>
>>> See above, yes. You'd be surprised. As somewhat corroborating
>>> evidence, there were tons of problems and churn (within at least Meta)
>>> with DWARF not supporting more than 2GB sizes, so yes, this is not an
>>> abstract problem for sure. Modern production applications can be
>>> ridiculously big.
>>>
>>>>
>>>>>> +       } else {
>>>>>> +               struct vm_area_struct *vma, *text_vma = NULL;
>>>>>> +               VMA_ITERATOR(vmi, mm, 0);
>>>>>> +
>>>>>> +               for_each_vma(vmi, vma) {
>>>>>> +                       if (vma->vm_file != sframe_vma->vm_file ||
>>>>>> +                           !(vma->vm_flags & VM_EXEC))
>>>>>> +                               continue;
>>>>>> +
>>>>>> +                       if (text_vma) {
>>>>>> +                               pr_warn_once("%s[%d]: multiple EXEC segments unsupported\n",
>>>>>> +                                            current->comm, current->pid);
>>>>>
>>>>> is this just something that fundamentally can't be supported by SFrame
>>>>> format? Or just an implementation simplification?
>>>>
>>>> It's a simplification I suppose.
>>>
>>> That's a rather random limitation, IMO... How hard would it be to not
>>> make that assumption?
>>>
>>>>
>>>>> It's not illegal to have an executable with multiple VM_EXEC segments,
>>>>> no? Should this be a pr_warn_once() then?
>>>>
>>>> I don't know, is it allowed?  I've never seen it in practice.  The
>>>
>>> I'm pretty sure you can do that with a custom linker script, at the
>>> very least. Normally this probably won't happen, but I don't think
>>> Linux dictates how many executable VMAs an application can have. And
>>> it probably just naturally happens for JIT-ted applications (Java, Go,
>>> etc).
>>>
>>> Linux kernel itself has two executable segments, for instance (though
>>> kernel is special, of course, but still).
>>>
>>>> pr_warn_once() is not reporting that it's illegal but rather that this
>>>> corner case actually exists and maybe needs to be looked at.
>>>
>>> This warn() will be logged across millions of machines in the fleet,
>>> triggering alarms, people looking at this, making custom internal
>>> patches to disable the known-to-happen warn. Why do we need all this?
>>> This is an issue that is trivial to trigger by user process that's not
>>> doing anything illegal. Why?
>>>
>>>>
>>>> --
>>>> Josh
>>


