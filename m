Return-Path: <bpf+bounces-70219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21838BB4B45
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D243B69FE
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C927055E;
	Thu,  2 Oct 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q2bCGrfw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2924501A;
	Thu,  2 Oct 2025 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426545; cv=fail; b=IMBzyUviTJSTniopM8ruDvubKgx9vlkuars3lNKrZjsDx5ZIZ+fwT4DQAkSMry6ZWgyntx5VXi7QoenJ2LYWz2dVlLa2gs7VgKopUBJXh1uHTyHKURFbY4gi4I4gSGI8vNhLSwj9iDpsCXZBsc2VH3LjurcTQa/wbDyGBgPNXAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426545; c=relaxed/simple;
	bh=b/vTN79h+8eeAeQcP2/t4mEnIl4/qMA+28qeKhRSrs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i+YcjEA2xj+fzU3XXYk+/zNNNQV8HN9uTeBsIPJYsXMu0UQr7f7TU+GnDQF+oBGQleX1zlqPZ3/YLNzvKp2vm7UY73w0e9IcBnZKTM5hSnwhGxZBqhVdzuNdWAoSUZHNHij3Hk8A8dF168qydBGH9yhGsMbVdzNzgFyLnPdsTJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q2bCGrfw; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5929Lsic005505;
	Thu, 2 Oct 2025 17:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XcrowPrwlHjS/raTUmwmUjusDkNOXfs+a9AGzaGXgB0=; b=Q2bCGrfw2OqAJIrR
	wK5WHiW9wYOm7fuaRQwDrUyw6nFOmf1uUan+BAnZ1bDVKRFfJwKDJl8cykZF9ypg
	gr1Aik8C89P8W3vObBDFpMTAvJHCNwNxKpVicSk1LiXyOJwszXTunHI/lI+H1Y4O
	qANkyQNihnTwGHjwD+rtsRxMRH2S89ETWM3DOCvMBPvosnApWQKTtvB8F4TKAPqb
	C11CWWMxl6uOoKpRIAd1oT5Dgn+0D+eECsmgrNIJaI8tqq/ZBhdlRdHBRleh6nMO
	uOKupfHcXjYUIK43fNQwbvCKVHlOvOqPHp6gFfewhJoo5o9lg5qB32u1RAxJ5rBB
	y1SbVA==
Received: from ch4pr07cu001.outbound.protection.outlook.com (mail-ch4pr07cu00100.outbound.protection.outlook.com [40.93.20.96])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdr98j-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 17:35:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiSIj7A6r2Lx7mlCsAgwj+6Q2XbCrGcsFpWuc6hPBPWc5H0uFr8NtOQ0VKtuRULAFJMCnNOnmF1e8jEtSvR0kJ0PGPL201BgmbRUQYpolagFHy/C+kKW10Jk3pq7pu0dAemLf5sbd27jEBsQIoW1dlVK607hq1Fdr1rh6iZ/7n3l+tCuf0MJJMnj0RBmjySpeErO/IKQ2gPxhrB/ebpl+AEiZ6fHw/1atzsjIB9Dspxrdjpmv0oP9s3p7POrOzyKrxxJis0nGVV7CpxlKjXEFSl+lRhlTxBY8lbgtDfY2nuLP+hvtL890CWqC5XQIvdJLfzAtqcMMZpFKnXpv89pDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcrowPrwlHjS/raTUmwmUjusDkNOXfs+a9AGzaGXgB0=;
 b=rurwfR2HmOJSIODPXfLUhR/KiBoflzfcoQHnFNGQuH2jA+2oPuMxj54Qb/FxaCSsQzTIfY7a6XUDdwTnvWvZ5Ax9IJFgaYhnv+ymyQ1oWqJma80gF+63ZuAGlkbrfWXRobz2RB6blWW5nCVooF8YavvWcvdUOhLwOS4Ul686cQZr/66nlyOH1GGW3lBl3onu0szIwu+MbnAptP1QZ5Kdwy2NQ33mjsdwCvhsvxJIrVYRjb4fgcmZZl8yhs9AS+c+ZhrCLmHbCDfIrTXUaYEQaJGA3m1Wi+v2s3vH6C5e2JhUuWPT8M4Ydn7xyyU5lewQvZTdkPl4kZOJPo/dzzSnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CO1PR02MB8460.namprd02.prod.outlook.com (2603:10b6:303:158::23)
 by SA1PR02MB9892.namprd02.prod.outlook.com (2603:10b6:806:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:35:09 +0000
Received: from CO1PR02MB8460.namprd02.prod.outlook.com
 ([fe80::2855:a72:3146:a08]) by CO1PR02MB8460.namprd02.prod.outlook.com
 ([fe80::2855:a72:3146:a08%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 17:35:09 +0000
From: Andrew Pinski <apinski@quicinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song
	<yonghong.song@linux.dev>
CC: "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>,
        Namhyung Kim
	<namhyung@kernel.org>, Sam James <sam@gentoo.org>,
        Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland
	<mark.rutland@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang,
 Kan" <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Andrew.pinski@oss.qualcomm.com" <Andrew.pinski@oss.qualcomm.com>
Subject: RE: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Thread-Topic: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Thread-Index: AQHcBmWTajyP34/TW0O1QlIpFos8n7RWSFaAgAAAh4CAAA5UAIBZIM8AgAAAStA=
Date: Thu, 2 Oct 2025 17:35:09 +0000
Message-ID:
 <CO1PR02MB84601693B2ECBB323297B4ECB8E7A@CO1PR02MB8460.namprd02.prod.outlook.com>
References:
 <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com>
 <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
 <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev> <aN629m1MlMXYh1te@x1>
In-Reply-To: <aN629m1MlMXYh1te@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8460:EE_|SA1PR02MB9892:EE_
x-ms-office365-filtering-correlation-id: 53e92111-4b3a-4481-1d37-08de01da08dd
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6DgzYe3GFbHk1up6PMzuFzqDCXNS5fJ/e82nISMZMKXzaoOPvjX+pqIB1XoX?=
 =?us-ascii?Q?H0pi9CjDDbQyJpCOZw1Z2sh5rpo3aBK3s7XOeNTpKKCjKXNpUnh0zHIkkLmZ?=
 =?us-ascii?Q?jnktv16UApJwBVXZOZRbC23oovC5xsm3HnJMqq4KMR+XbmT3Jd+GE+g3Gi2d?=
 =?us-ascii?Q?t3I2SU8BHZj+3CCX0tBF46NKogelOOhn9G1TlEHg8hMBzcatpo1WJy1R+p+3?=
 =?us-ascii?Q?xVMEY2WzzRNmgBEYFZm7IGvT6isT2GRZSGdUmg27YLdijGxOkySOpwgjTay4?=
 =?us-ascii?Q?9XDcCngv85OOrCPGP1sclv/zSZ3QTfp5ftvHzKRf95c4vsQw3Z4sLapDPyFN?=
 =?us-ascii?Q?faMia11T/6zWVeLlcgHooxZSQzHB3/aqKVOFsJfRAXTvn4PE5Jw3RK/lGKMJ?=
 =?us-ascii?Q?iXwjBVcX1rBpdbg66uoz86J7gU2mCnFLabr0cKcem+V5OsoOE+eKmyJ4RFDp?=
 =?us-ascii?Q?M9jnedOEQlevwaqilJ3zj+jtf7x8u4fcKzhTS5ZHCfcVEa0YIqpByaUinwEL?=
 =?us-ascii?Q?JzHGJ+ZviI1IWMLWL0LhIte0yf3Tdtn5gCftPnDTwn8AR1/VydzdaVPMmRKv?=
 =?us-ascii?Q?XcszunnRD2q56HX9eXbKq5Ei/+lvT0KFTr6Zx+Dh5MsigS27K2QDcA0JKfww?=
 =?us-ascii?Q?mUdGG7JUy9SQfxZW60vF8SAIsjxpyvDAx0uoo2ZBrwHv0DuA8esSH8H+BeIg?=
 =?us-ascii?Q?RqaHpzu97+boZ1ezL96lQ43CzsuE5EwhO5j3x83yVv2hpIeyWkj/wHCtq7vf?=
 =?us-ascii?Q?i+/vpn1QTP5VXTDWVkVJZfPuJlDDivqB6E60/UZu37NwMI+ybw+gUgOa70SK?=
 =?us-ascii?Q?Y4HzudDZNLkj98HReYoA+CnGhZzIZ7t8RvMR9dgZtXhDeTe2Us/8KrA4i2f+?=
 =?us-ascii?Q?RWUeLsGO4yWX13x6zhUCGDqRFtHLDbmAXcaK9SIepZ9chp2As0VrCaPlPQA7?=
 =?us-ascii?Q?jkoUecQSYmQGmt0MWegRkGrF1l4yRd/1C3ulJ67ARKGMPfaZHFYUWa2Sntqy?=
 =?us-ascii?Q?Zg2m0NppHkSYCqN+cmvYOJSbhm32yfNnH5AGiJl9G/pZjIzvAdfdkWjNChwO?=
 =?us-ascii?Q?EJkIxCAtzZvXCB2NDwzHn3D+VhpTgni66cfPkDRjtH8jOs+mib0BcjZv+vpq?=
 =?us-ascii?Q?sJpOy34vT46L1dvwR4zVm/chA0+dQ5cXGslEtr2NHgYrLC7d/EUMFmsDwCfL?=
 =?us-ascii?Q?9K4cf6C8znUnSpKVFDBDAu04d7jKc9ZOXs6VrNpPKPBqDXihI4E3sStrceCR?=
 =?us-ascii?Q?ZxFzQSEb4K9YJVAmA20zu5xuWD0yZsd9TZof4edxohkifR11I2VOHamqurXz?=
 =?us-ascii?Q?dX62fz+j1PfWJMxK7338rA5WeWukMZ4Q4eJmO2v82MvbmNPx3T3pN6Z9JFom?=
 =?us-ascii?Q?lQiJFkFrB7RezdRUSa9XoZUScp6zYxMj8oF7BLZVF9SUWWjUUmxqxHU01qmI?=
 =?us-ascii?Q?WbDVAqgVK2vLoV9WlXNGvzkNO2U1rN9X1gxemc0O8U0GtmCIo0UBRF5gRCyN?=
 =?us-ascii?Q?qYSNM11kDO8Lc23nnWYXAR3vozwJryPJpEHw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8460.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kUn0O0w+dXQjrj9uxUUkV3D4pEm1FcCbBblT6Fs/vLJNXABpcSKTdv7ID/b2?=
 =?us-ascii?Q?uOUs4N63ERqMkK/audFtPjc4dGCEbu0ZrW8qB5LC1WtRhPQmdNpypIf+G80x?=
 =?us-ascii?Q?v+xUEJ3gSDXQqnsbrcX+KnLypyZd7Mb1DCrszL2d0P3LNNYb/z/HOyubXJzP?=
 =?us-ascii?Q?6q6izpTVyeoQo4LyV2NHqXZVfc1U7ckh1BeoToqAuAXKAKmJ05Esxh7gS3j9?=
 =?us-ascii?Q?6YL07iUL4j23swcoLy3e9ZVRqhhkeYp8gj+HEHar/wY8lFgT/ZSyf1CvB4wW?=
 =?us-ascii?Q?it8vJ26CYxxY09W3UJXS1qXrWemQlFq94wwLDH2z1HAnV6r4FlNux46mqEYc?=
 =?us-ascii?Q?0mVJuLtuEH84rBMl+at+jzWO5psyG8wQhWVd7oRSTqXTxLFWOVTeoweMUcTF?=
 =?us-ascii?Q?U+Ierh9v1E4AzG6guxPffvOoRPw/Q832wsIi9zUSZhzZ3EL17gTcjwyeLLXb?=
 =?us-ascii?Q?UKpX5OrCvD/sNMnS9F4Vo5He/Cd1lwqwjPMWcL5hdjg4fNS22udR4rxzCwSr?=
 =?us-ascii?Q?yg5mAlyUzz7iAN6O9uekd1hMN2YX9XN262eQk2u3Gn7fI8xut25BJKnfy0jt?=
 =?us-ascii?Q?SZR5YbsqoaaUuHN4I/2yCHyzIRty731Cd0Ah67uZ7hMN9KCO7/TYZAriYQah?=
 =?us-ascii?Q?UC45532U/eE4kBur5rG5Dh91bysO6kIzpUR+AYFyNVBEkI3lNAJnXDQCj7ny?=
 =?us-ascii?Q?0tmJod8gm4GMMEYYXMBdAtNECnUaMUeZAw5Gdoyqgm9nVF0hFKPTkAkuu9bN?=
 =?us-ascii?Q?JGKaRDhuhhBsvYA5RVYTLWmaWHROVxcnxDIZsR6uOeoay2KQOBSciU9MIhce?=
 =?us-ascii?Q?8MiifunEkMaQz5/P0g7fIhweOCjlcijsJfWcggFaYfGXe+XiYEzoCJ78ifke?=
 =?us-ascii?Q?ae3Vmz03vXZQ+UyOXJC4wJdbez8bl053++Xg8BbqSipMWDKt3sktRMWyog2p?=
 =?us-ascii?Q?GpvISexuhj/PiQN8UFviPcd7/kidvSdiLA8l+3i27D7TmLf9g/yldoFqXv7z?=
 =?us-ascii?Q?RY8Om7t84XBOWAAGIc132igFODScsDoeeMvtEZLXFxKk/v5O/p2TYkbwQpWQ?=
 =?us-ascii?Q?LeAvQGiYJ5c62UFa7R2BP9CZH7YZAoBAWs753xWvDZ5Yff1zaotUNlkmRgH0?=
 =?us-ascii?Q?1l7ACLEH80/qlbakFIstQy0f/rlkuK+Sd7BubwGTzKN/Y8EbITQjwSshcGF4?=
 =?us-ascii?Q?j2Z6qoj2X1rgprz5bdvS/5lh5iTR8HvRJB/QDizxjUWKLGqsMqakeycoOala?=
 =?us-ascii?Q?tzQPULEcmgv+n8ck5sAP1KsVgiiSlhzB2y1Hr/ujT4/nf0T5ChOwPmYPm6cH?=
 =?us-ascii?Q?6lzBlzMYwEoovTN5ujwAbWBgLUdK4F0UbPxajIYRtoQNgOa1KMoFltiuHusr?=
 =?us-ascii?Q?hXbD3UCmfLm4Q81ZNV2JpTK9e5wOYKKXyKitUTTOqKSt/IxTopY9F0WiPa2V?=
 =?us-ascii?Q?n+jLVBr7z2jIIZRv/Np2GtWxfjfXgzRzceEOhabQRbRu3pSawAnYVGS+t34R?=
 =?us-ascii?Q?TqIPiamuxm3V7UIBGcNPus0yHeFoUfYHQ+vmmFeR1vNurOnPy0NJjZAMZtVT?=
 =?us-ascii?Q?3IwGJUbWk2t8AyY/os01VtrcSj3rzKMgZ4fuficW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EETBSTnY6ypdC/rfMZJEKMXQRcM4njrljmgV12ZnI6HRC5kKPLc3HPQUnGaVFYSvGKYXIaujVSfrSPN2rWfJll6g73Ztsft7FKCIfg46vCksCfSYHIvqYcVv3D/owfu7hHdZZHDo/sqNf2krSIkQduZcj2kH5uHaV0I9SnFOhclfeK7yZ4b041LFXLb1J/PP9zSlHCw14dddaSNlodgnN8ZEHjmDdL695rbKkDN2zn/d4zBzGo4Zp/r0knJUjhnUN3uNvRM9TgE4gt/kNa02E9Zgzk+z1hCIcjtEi/Fmwq632+15hcgElHTqE06Z1IMgbzRbeSu6HwP+vMtrMj6Cjkc4xZPkVSJmsOAwel/tId6SHS99kcGmIeHj3vRB14PjwLkWVeDL8fiFWBCIJQxMIm1JxJTrkzXadQxrQFxts/n/DJAfRgh0wC7CYg3TIWAIvlZh+jEROGeneBYe8nPbphL9G8jFjThYQJiLb0Q28poqXHHmvE8mtWj3llL2VPiwTDWMciWldouilIfCzey+OnRGOiBUbeLbOe0ibyCnioigaDpRmTqlmKz+36nSHm9vmnn2Q3Vi+PUPgE6Vk/rM4je52NLvuyXsd3deA+vJrYYsXNaHA5JvLvVh3+Q+f+i7
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8460.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e92111-4b3a-4481-1d37-08de01da08dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 17:35:09.6377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HMFHPNwJtLHoAv4FxG+n7sAM1g1ChHMNkd6r9QRKNVZMn7pubwScIeo7n1gx+KHIrT+4Q22we1sJatTmERkrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9892
X-Proofpoint-GUID: H5zjcIYEKzUE56oVCukJrwU1rslbjm6e
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68deb7d8 cx=c_pps
 a=9xaBLH33BRUJl5e4Wy82dw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=7mOBRU54AAAA:8
 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=L0oIykV7R1i6uE_vGtwA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=wa9RWnbW_A1YIeRBVszw:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: H5zjcIYEKzUE56oVCukJrwU1rslbjm6e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX0cOyzZl5jlzF
 0f0UJN+jOuENMvYqs9bLHFss5Spql6wjJkN8q59FkqzzIhFFQTPpnftxWRiSDUYugAjwU5wFf1y
 I2i/fDN2dnwdqeGVYEynLqlR354o0rPTiOlFBLlDqgecYHTTOjptNecKkY7MbHaZWj1hMDpTcY+
 JJ7cw+ERhL0OJDARAQCQB1NKFInUQ/cKpkqNhPgFd2NdlT7+kfha6D1Wa8BfPAI8T6E+X5u7zQU
 rSA7gtuK8TYLm7gblRMQQF36z7q1KHdxadu6TaTTinVveurdGSQHWj/0QQA2zHyv3Hj3V7CMjil
 fFJbAUU82Xee2weqdyym2Zva6zwESe8jUIJEbEi3NtPop6yUftTcd2tZMGj4hOx0k9cjAtw8Yhm
 mJU8e2SB2oFgHg1hjGR8Txo6qeG2Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036



> -----Original Message-----
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> Sent: Thursday, October 2, 2025 10:32 AM
> To: Yonghong Song <yonghong.song@linux.dev>
> Cc: Andrew Pinski (QUIC) <quic_apinski@quicinc.com>;
> Namhyung Kim <namhyung@kernel.org>; Sam James
> <sam@gentoo.org>; Peter Zijlstra <peterz@infradead.org>;
> Ingo Molnar <mingo@redhat.com>; Mark Rutland
> <mark.rutland@arm.com>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Jiri Olsa
> <jolsa@kernel.org>; Ian Rogers <irogers@google.com>; Adrian
> Hunter <adrian.hunter@intel.com>; Liang, Kan
> <kan.liang@linux.intel.com>; linux-perf-
> users@vger.kernel.org; linux-kernel@vger.kernel.org;
> bpf@vger.kernel.org
> Subject: Re: [PATCH] perf: use __builtin_preserve_field_info
> for GCC compatibility
>=20
> On Wed, Aug 06, 2025 at 05:27:02PM -0700, Yonghong Song
> wrote:
> > On 8/6/25 4:57 PM, Andrew Pinski wrote:
> > > > -----Original Message-----
> > > > From: Namhyung Kim <namhyung@kernel.org>
> > > > Sent: Wednesday, August 6, 2025 4:34 PM
> > > > To: Sam James <sam@gentoo.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > > > <mingo@redhat.com>; Arnaldo Carvalho de Melo
> <acme@kernel.org>;
> > > > Mark Rutland <mark.rutland@arm.com>; Alexander
> Shishkin
> > > > <alexander.shishkin@linux.intel.com>; Jiri Olsa
> > > > <jolsa@kernel.org>; Ian Rogers <irogers@google.com>;
> Adrian Hunter
> > > > <adrian.hunter@intel.com>; Liang, Kan
> <kan.liang@linux.intel.com>;
> > > > Andrew Pinski <quic_apinski@quicinc.com>; linux-perf-
> > > > users@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > bpf@vger.kernel.org
> > > > Subject: Re: [PATCH] perf: use
> __builtin_preserve_field_info for
> > > > GCC compatibility
> > > >
> > > > Hello,
> > > >
> > > > On Wed, Aug 06, 2025 at 01:03:01AM +0100, Sam James
> > > > wrote:
> > > > > When exploring building bpf_skel with GCC's BPF
> support,
> > > > there was a
> > > > > buid failure because of bpf_core_field_exists vs the
> > > > mem_hops bitfield:
> > > > > ```
> > > > >   In file included from
> util/bpf_skel/sample_filter.bpf.c:6:
> > > > > util/bpf_skel/sample_filter.bpf.c: In function
> > > > 'perf_get_sample':
> > > > > tools/perf/libbpf/include/bpf/bpf_core_read.h:169:42:
> > > > error: cannot take address of bit-field 'mem_hops'
> > > > >    169 | #define ___bpf_field_ref1(field)        (&(field))
> > > > >        |                                          ^
> > > > > tools/perf/libbpf/include/bpf/bpf_helpers.h:222:29:
> note: in
> > > > expansion of macro '___bpf_field_ref1'
> > > > >    222 | #define ___bpf_concat(a, b) a ## b
> > > > >        |                             ^
> > > > > tools/perf/libbpf/include/bpf/bpf_helpers.h:225:29:
> note: in
> > > > expansion of macro '___bpf_concat'
> > > > >    225 | #define ___bpf_apply(fn, n) ___bpf_concat(fn,
> n)
> > > > >        |                             ^~~~~~~~~~~~~
> > > > > tools/perf/libbpf/include/bpf/bpf_core_read.h:173:9:
> note:
> > > > in expansion of macro '___bpf_apply'
> > > > >    173 |         ___bpf_apply(___bpf_field_ref,
> > > > ___bpf_narg(args))(args)
> > > > >        |         ^~~~~~~~~~~~
> > > > > tools/perf/libbpf/include/bpf/bpf_core_read.h:188:39:
> note:
> > > > in expansion of macro '___bpf_field_ref'
> > > > >    188 |
> > > > __builtin_preserve_field_info(___bpf_field_ref(field),
> > > > BPF_FIELD_EXISTS)
> > > > >        |                                       ^~~~~~~~~~~~~~~~
> > > > > util/bpf_skel/sample_filter.bpf.c:167:29: note: in
> expansion
> > > > of macro 'bpf_core_field_exists'
> > > > >    167 |                         if (bpf_core_field_exists(data-
> > > > > mem_hops))
> > > > >        |                             ^~~~~~~~~~~~~~~~~~~~~
> > > > > cc1: error: argument is not a field access ```
> > > > >
> > > > > ___bpf_field_ref1 was adapted for GCC in
> > > > > 12bbcf8e840f40b82b02981e96e0a5fbb0703ea9
> > > > > but the trick added for compatibility in
> > > > > 3a8b8fc3174891c4c12f5766d82184a82d4b2e3e
> > > > > isn't compatible with that as an address is used as an
> > > > argument.
> > > > > Workaround this by calling
> __builtin_preserve_field_info
> > > > directly as
> > > > > the bpf_core_field_exists macro does, but without the
> > > > ___bpf_field_ref use.
> > > >
> > > > IIUC GCC doesn't support bpf_core_fields_exists() for
> bitfield
> > > > members, right?  Is it gonna change in the future?
> > > Let's discuss how __builtin_preserve_field_info is handled
> in the first place for BPF. Right now it seems it is passed some
> expression as the first argument is never evaluated.
> > > The problem is GCC's implementation of
> __builtin_preserve_field_info is all in the backend and the
> front end does not understand of the special rules here.
> > >
> > > GCC implements some "special" builtins in the front-end
> but not by the normal function call rules but parsing them
> separately; this is how __builtin_offsetof and a few others are
> implemented in both the C and C++ front-ends (and
> implemented separately). Now we could have add a hook to
> allow a backend to something similar and maybe that is the
> best way forward here.
> > > But it won't be __builtin_preserve_field_info but rather
> `__builtin_preserve_field_type_info(type,field,kind)` instead.
> > >
> > > __builtin_preserve_enum_type_value would also be
> added with the following:
> > > __builtin_preserve_enum_type_value(enum_type,
> enum_value, kind)
> > >
> > > And change all of the rest of the builtins to accept a true
> type argument rather than having to cast an null pointer to
> that type.
> > >
> > > Will clang implement a similar builtin?
> >
> > The clang only has one builtin for some related relocations:
> >    __builtin_preserve_field_info(..., BPF_FIELD_EXISTS)
> >    __builtin_preserve_field_info(...,
> BPF_FIELD_BYTE_OFFSET)
> >    ...
> > They are all used in bpf_core_read.h.
> >
> > >
> > > Note this won't be done until at least GCC 16; maybe not
> until GCC 17 depending on if I or someone else gets time to
> implement the front-end parts which is acceptable to both the
> C and C++ front-ends.
>=20
> So I'm taking the patch as-is, ok?
>=20
> But first we need the Signed-off-by tag from Andrew Pinski as
> he is listed in a Co-authored-by, that I replaced with Co-
> developed-by as its the term used for this purpose in:
>=20
> Yonghong, can I add an Acked-by: you since you participated in
> this discussion agreeing with the original patch (If I'm not
> mistaken)?

Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>

Note my email address for doing Linux and GCC development is Andrew.pinski@=
oss.qualcomm.com . It was apinski_quic@quicinc.com but that changed last mo=
nth.

Thanks,
Andrew Pinski


>=20


