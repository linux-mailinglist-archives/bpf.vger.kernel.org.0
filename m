Return-Path: <bpf+bounces-49568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013DA1A0F3
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 10:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81E9188E44E
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7320CCCC;
	Thu, 23 Jan 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jevo159H"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08591BC3F;
	Thu, 23 Jan 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737625261; cv=fail; b=c4oF92azyvIQXYv14UXhtnVpIe+OL4e5LUO6yg3qPBBT+9Mgr8eppWrR+MYsgsxw8hgBdDaAZXvU85uvRFL1hq+LZbUrYUu4Qat4tud48jeKuesGmMWOsfpK4QkofwklhhhlwYlVEfMJzcMYQMJl+FhlPygr5ER7oHGyXpbw63M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737625261; c=relaxed/simple;
	bh=+wWd8TXxHxPou+/ue6ybd6Vp5uC892ZRbEQPg+pdhBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SjZPfyRPQ/Xt46CRoTwm03E7htTwvgkcsT6f9y1ZQ4x8MIYggYsz96OMUHkaUxeHZiqmeYN6jOT86x6DHzbffh15KHea2U+5Bc6jOD3y4bTWYcDysG6VPvCfxMhFP2ckHc1AGhfquStcRIuXwp/VRrGtRbh/EmNitSmSJiWaGck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jevo159H; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdIIlE1XB4yAQLdlcv/N7iIhhW6bhmBREzQplUJu/Z9qQ171Y639QabWv7e9cDrn4VEnsrTNgwbXUocvhUaxtdNVz/XLeff3HM6wfmYWLb035426JYcID+1kRVXeaMjG1utL6KmGY8fbgiyVGuESPAxkpdOKs9pM8nonpkVsVpPcHBH+UGTNPGgmWnxELzGwiIjnG8VgBP7SdXFDz6/OXOj+WdxwlwAT4K8XUdUWvR+tD+o8tHhwFttbE6YpbJYopNSF4iwGDD0p5rR5OmXOJvGjHPZZqp5ztEepOolxn8/UENo1hhA0o4vuIqQCFboBb+cId2wpzfhtvFFArGPPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMfdAnrC/gez4Uth7TjiexG1lFwYM5j2OY64Foiz/84=;
 b=mqya1xxdD8CBXq3huDUV7SAyGIqpepLXlTLvko+opw+ItB40M7LnM7Xz6dYy9RwX05kqgriICoLkA0xz37EquA0myeHOcSm/gaLafSrUlZ1HalOE5VfhBbghZFIWLyLdFAJ7ukr0m7Z83mGIWWTFtOScglfj7oKpbhARikiuQR6zs4BsADe2o4CGKsy3teeGqI8TbdM44vVwe4azqBy7npFucIDs+X+6DRJl3aj4I/OSi9h8i+c6qpikwGWSPxish6GNeKubaozOCQ2niMP+5rxghVvoTYtiAXVwSBwQsOmOL97F+i9PfxxMcw0De/vBdfkpXk3K1ntKRV+Wh3sVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMfdAnrC/gez4Uth7TjiexG1lFwYM5j2OY64Foiz/84=;
 b=jevo159HLA3PJGsOuaOREZsbQ4ne4qMdd6PZi1iUuA3QIBMosXrfjA2fnL0GSs8aYrDaowPGX0jJ+66pKudH6cR9UnEgijCvYiFBRyIUcel5adPiuwohUD1J3mUIEb4xQkKcVFecq32u0jYTkhpXS8b94d5waPEo8vb2wvNxUWCtIgT+QvIOL4A8oZz0nkVDXbJGo+ti/UBZVoAJyrVUFKiD6hqKsg2u73RmgoojMPV9lDeYPwPI9T6jSQo1Osg0pjfHyaZXWikLgcWw59qUkh8lVHTSapB68PDfiW2NrgFdjg58uZpHl3Rujd6KFZoh7YwrZmEAxNLKF7q1O6FGKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 09:40:57 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 09:40:57 +0000
Date: Thu, 23 Jan 2025 10:40:52 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@meta.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on
 selftest
Message-ID: <Z5IOpOD9cs2fLaIg@gpd3>
References: <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>
 <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
 <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
 <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
 <Z2MV001RfiG7DNqj@slm.duckdns.org>
 <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
 <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
 <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
 <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
 <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abbfb66-d2f9-4d9c-b845-08dd3b9209a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXpMTWlaWGRqZUxzRlkxRmxiY29Ca2x5V2ZHQlpIVkFVVks2WlBpTWkrakNi?=
 =?utf-8?B?SFUyWkpSYTdpdm1Eb0M2aTZmL2ljNXQrVFJ2ajhMSFdGTWM1TzIrSTk2QWMz?=
 =?utf-8?B?UHc4QmU1UFRzMGVyU0x1S3BDRnVxeTlmR3JCaDFSdnlnY0hEaUdlR2FPRTNE?=
 =?utf-8?B?N0V0K0ZDRkNLTk9JOCt3L2hmaUYzZTQ5bFZxZDd5TzZ0ZHhIa3A1bmNVcDMr?=
 =?utf-8?B?eXd0NzlHV1daT09OZTBNamF2RkVNeTFUVXVLT0lFekk5cUdtOEdZa0pBS3F1?=
 =?utf-8?B?cmtKWDNFeTFoaHkvUnBKVGxGTTFHZlM0b0pWOFJWMHZhcGkvemE1d2tPK21X?=
 =?utf-8?B?ekpBYUJhUVdtNWdQSXRYU2VzZXo1OXpRSFMwTXp6NVpxYm85KzBBVlkzZTg2?=
 =?utf-8?B?ak8vbDR3dUh0TDU3U2J6NDVIOG51aHpSTVltdm8zSHVNTmZTbU4yVndWTkky?=
 =?utf-8?B?VEtOcGJSbURTeGlWbmtPRXA3cUt6Q3MzenRuallwQXRBQjlFbWRWbXN0OGRP?=
 =?utf-8?B?bHZ4NzFsdVptVUJUL3E5U2l1a2FrbTM1eDVnSmRqbDBFa0FrZVdoZ0UvZm5q?=
 =?utf-8?B?K3JjaTdSbTJWZ1VVMGJHZE5jMnNWZFpQK0xJMGdycUxkalg5L3ptc2Rnc3F0?=
 =?utf-8?B?OHdvOGxJQjUrVEpSQUs5bGRjTlNCbG84Z2UyR2E1Q2JOKzliL0NSRUFOZzU1?=
 =?utf-8?B?ZXNGU2tIUHJkcmJBYnhGWTV4OXN6cXpnSWxXZkdwcytLQWxyYjBMRHlJWFJT?=
 =?utf-8?B?Vm9HbG8vbXdSM1RYTnFqR0F0VzhLK2RKMlpxdndNZy9SUVRIRTFjaC9nR0Zj?=
 =?utf-8?B?NVQrTVE5NGMvKzdqSW9SR2R3eEU2QXlDN3VIaEptWHh2ZENJQlpESkhRMjBD?=
 =?utf-8?B?Uy8rVzgwcnVVUnM3M0ozb2JsRUtaeEtkWENJZEhoWGZ5RHpyOC8wQ2dmeGNv?=
 =?utf-8?B?aWk0REpua0ZEU0xMUnBZeTZnaWRoUnZva0RYeFlpb2xBQWcvMHFScysxVmI2?=
 =?utf-8?B?V3VWNm1HMGxLQ2lSWXBOdGZURWJOS1IrQlUrTWw3MThxTkFnRnJteWpLWG13?=
 =?utf-8?B?d3EzYzg5UEh0d2llQ0hlaVY1L2QyNVdMSHJxVzlsSmNYdU9Ud0dIa0FhQ1kr?=
 =?utf-8?B?OVRtaHh1VDFYdG1IMFZPU2kzVi9vcDk4ajNBb3V3bXpXcGFvMmp1RGwzMkxu?=
 =?utf-8?B?Z2NhcllnVHNUL0RDaDJ0NHRTSFVFTDdXSy9PbnJBZHdNWjBHN3UrbTdMenI0?=
 =?utf-8?B?emdORkJyT2RaNGZrME1NenE0Ym1NdWs4QlcrTUYwMFRONDFHZ2NGNTBSazdV?=
 =?utf-8?B?UlJjTkVDRmVlTXNIWDlWdVIyOXpKeExSNkNtZHFsZ1RVcVBCSTNlK0QzNTI1?=
 =?utf-8?B?Tm00Z2hzYVdvWHhWWTZmekxtbGRpcmFpV3RPYWhmTEpJZU56ZURGS0VBTUk4?=
 =?utf-8?B?UkdCZWYyT1A2L0dsTUl0WC9mZ2dUM1pGMkhlYjFydGNoV1dIcndwTDA5UUR1?=
 =?utf-8?B?NTdXL240enIrVXNWKzJxNGJ4bzdERHVVaVNtU1FCZXdGdkZoWVYySm9qMm5r?=
 =?utf-8?B?c2hsNXdjaDU2R3ZFaUVkb2JaTnh1OXBPcWc4OW1kclc5VysyeVc1WjJySU0z?=
 =?utf-8?B?RzBDR3hFYnU1Z051UTNhbUlxcmMrT2EvQjNpTUUydmkvYkY1UkErNlBFdDFK?=
 =?utf-8?B?bmh3WVFGNUxsSEhZQzJ0WWZiK08xL29yVjZVMWJ4UVRUdEpDRGI2UGxBaHBh?=
 =?utf-8?B?eXJtQWEyMTBJRWt1MlFnV3IvangrL2dwOGlZRE9FSXUrUzFNTmZrVG92eEFv?=
 =?utf-8?B?dG9YMGNEQkpCbVRvYytxQ3VJaUp4ZTdMYjNOenJ2QkZCbVhEdUVCK0JnWTV4?=
 =?utf-8?Q?auaZ9e5fXE1pJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjVwRGxwdFhxWmgvVE9qM3JiUWVqM1piZUw1UTBTVmRRRHJDNXdhcjFtbXFV?=
 =?utf-8?B?Z2E2WEFWQ2IzVkNsdm5vZVVDWWZyYTRxZEs3cytlRGdOblAyV0UrSElYUWZV?=
 =?utf-8?B?aThkWkRuSldNYXNmYVpWajNmQ2p1M3BDZUNHSVhKQnpOY0UrQ01JTGxhVUtW?=
 =?utf-8?B?T3hEWlJNSyt6bm1QTiswZnRFUVFDU1FaekNHK1hDaDUyQjZ2Y2xCNyt5TUtt?=
 =?utf-8?B?SFJOMHdCUVRsMThCd0NJeWdCaHNabzBKbTR1YS9IQ080T3UxV3VBT2lwbkJm?=
 =?utf-8?B?YTIzN2NqSFVPNms3TWljQU9IamJqSjFHRnUwdXpYZEZiWnNHOWk2RkFYMStG?=
 =?utf-8?B?TjZ1ZTRJYUN5aEhkNlRwYUwraDZ3Tm1MMmFZWDZkRnRiMDE0N1ptdHZERHJi?=
 =?utf-8?B?VWU4cnNERmdRNE9KZ3RuZ2FhYUNXSzBteVNZbklWYW1XQ3lYUlFQVWk2eFpS?=
 =?utf-8?B?cXY2T2hIVHQ3aW4vb1A3d0JjOEF6ZVNGNWE4TEttcjdjMVVGOFNUZXNsMjNq?=
 =?utf-8?B?NUVBQzJwU01kRHJEUkhtZ2twK2lYTzdkeXpDT2o2NmlWcm1GRTZKa2x6RlFn?=
 =?utf-8?B?c0pzaWVLMmJJeUJ3V01nRDAyTHlYdEthdmdIR29IclEvaCt1eVY1MlhuNWVt?=
 =?utf-8?B?bmJKMjFXV3JTTjgxQ2JnQitiNndsNlM3UzhhQTA3cmJpdjcvaUFmWVViOTZS?=
 =?utf-8?B?aEF6SGpNMXhDU1NWZEpscndvWEg4TnR6czZkTUhaZjFlNnJleGtoWHJGT0h4?=
 =?utf-8?B?bHlCNmpydkJGY2Z4dXdxSWtvTys4V3AwWCtMZ1lraERFRlZpT055R09CQjdM?=
 =?utf-8?B?bitIemNZV29WT3FGSTNOaUNNU3hlS2RzdC9MTEVxS3ptRE9ZWDFGNzArZ3R3?=
 =?utf-8?B?U2R4cGxpa2g5NHFoWDV3ZGNqS094dVJRL0dobWlHejN3Q2E1YlJvV1lWbmlM?=
 =?utf-8?B?YUE2cVBwTCtSWW83c3c3Z2tlNWdVRVoxS3FNTTFhVHlxbHhqWk9uZ2JQYS9J?=
 =?utf-8?B?dzBSWnlUYloyOTNqdW1JMGh5aFQ5czljSWxQaXA4UTlRUWpZQzNXc1JtVWlr?=
 =?utf-8?B?d1BtcnExZkh4elk5VE41dS9weXQ2Q3dtMloyNXlxS2IzSWN0eEJkS25kNWxK?=
 =?utf-8?B?bWFzMEVhcFJxaEphS0tBK0RpYlR2YytReDJUVWZEQ05neGxrNDRLdGpkaVVR?=
 =?utf-8?B?TWpxRWJqUmdWR3B5TFIwcmNQRU94V2svckRCTnBYWlk5a1JXT2g2UmJaYlUv?=
 =?utf-8?B?aWVObTAzOEZIT2ZGM1pNcXRuY1VIMVJCSldPNWovV2VZNGgydzlGNWpkbUZ2?=
 =?utf-8?B?OVhZNEM5ZUQ5T3JvTGo0UzlwWkJCYTk5dndRdmovakRBZUszdDhpRzVKV0o0?=
 =?utf-8?B?Z1NwZ0I5UkJNbFM0QWUvcGtHM3ArZzAyOE1jT0FRUzU3TGxHSTAvZWFuYTBM?=
 =?utf-8?B?SU5BS1ZPMGlZT0E3bmxhN1gyTmM2Y21jRWgybnZ6b1VnL3BxNUF2c3ZQK2tj?=
 =?utf-8?B?WVVHeTBVUituZXdnUWsvT2N4cTlzWTFjdmh3WEtNcW10NGVpTzEwMFFFblJX?=
 =?utf-8?B?dlBJaWFBaExBK2JOck1US2Zkb0dOWG1HUXJjSnRFUVp6R0R2QVpEOGJ0M25S?=
 =?utf-8?B?dHNNNW0wa3J5TGF6UTJqbUZNTTZ1OUdsQnNsOEtIT3oyaXBTMjF0OGVHMnhO?=
 =?utf-8?B?RkFZK2hZMlZ3VDF1alVDaE96Q0hlZ3RsZzFkVGVDS0VGM0I2MUlMUDE3bnpx?=
 =?utf-8?B?U3djdWlXcUx1Sm9FVnoxaEh5dGRqdDR3VWhlUVdzR1JVVlJ3eGJ4R1NIUzMz?=
 =?utf-8?B?RVVDVTcwekJQWjJYa3dCVDVSdkJYaEl3cnFhNGFTS1dQN0IwYVZlekNCOVlR?=
 =?utf-8?B?SzU4cU12R0l6ZmVlc0EyWGkxRS9IMysySitvUklWWG1OT3dyN1ZIdiswR05S?=
 =?utf-8?B?YzgxeWdFdGZiK2draVV3Q2VyTDFtS1Z1TkxCc0FhaDVhYnRkQUNJZUdDYVln?=
 =?utf-8?B?NWo2UmtCTUoxbmtTd0pBOHBLZUFLcllxeUh5UldqR3lZTXBJRVlNZGxWeFFE?=
 =?utf-8?B?bWpWMFZNaFpwL2drbHZvWGs1RHJFNFNieDBLYUlYZEREbkkvY1BmT015cGtC?=
 =?utf-8?Q?Cg7JaxVVy7tvl7BGGNvPPU5cw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abbfb66-d2f9-4d9c-b845-08dd3b9209a6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 09:40:57.2174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tB8SzN7ysKY1Bri0nJhSlD7flQAdDCKUJhzO77FKlBJWwRZMELa9TYeSkCLLbm0R5xuuD/4Kr5y7+P4COlvVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

On Wed, Jan 22, 2025 at 07:10:00PM +0000, Ihor Solodrai wrote:
> 
> On Tuesday, January 21st, 2025 at 5:40 PM, Tejun Heo <tj@kernel.org> wrote:
> 
> > 
> > 
> > Hello, sorry about the delay.
> > 
> > On Wed, Jan 15, 2025 at 11:50:37PM +0000, Ihor Solodrai wrote:
> > ...
> > 
> > > 2025-01-15T23:28:55.8238375Z [ 5.334631] sched_ext: BPF scheduler "dsp_local_on" disabled (runtime error)
> > > 2025-01-15T23:28:55.8243034Z [ 5.335420] sched_ext: dsp_local_on: SCX_DSQ_LOCAL[_ON] verdict target cpu 1 not allowed for kworker/u8:1[33]
> > 
> > 
> > That's a head scratcher. It's a single node 2 cpu instance and all unbound
> > kworkers should be allowed on all CPUs. I'll update the test to test the
> > actual cpumask but can you see whether this failure is consistent or flaky?
> 
> I re-ran all the jobs, and all sched_ext jobs have failed (3/3).
> Previous time only 1 of 3 runs failed.
> 
> https://github.com/kernel-patches/vmtest/actions/runs/12798804552/job/36016405680

Oh I see what happens, SCX_DSQ_LOCAL_ON is (incorrectly) resolved to 0.

More exactly, none of the enum values are being resolved correctly, likely
due to the CO:RE enum refactoring. There’s probably something broken in
tools/testing/selftests/sched_ext/Makefile, I’ll take a look.

Thanks,
-Andrea

