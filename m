Return-Path: <bpf+bounces-12964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C877D2899
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 04:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93791C208D1
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 02:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B8ED7;
	Mon, 23 Oct 2023 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gGj2pLzK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA4373
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:36:39 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1DC13E
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 19:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyoUxkquBy2JH5Dc1pcMwRNRpFa0E6xXVutiRZBaYSC2KY+zRF/fl9HeZBUEmuZ8wSqP2c6+F7StbciRBD3i5okWEy6K68wf/znjWH3zVesqHdtlMG3ozPVNjEhYwzuh1QJAJjHX5YqzSSW89EGTysNWYLqdciVCFO8BbZixW+nKytmbiQXeO9T3t3uvJV8r03sHKn/PsxytFDC97nT5COASg1Ld8gnoAgCzG0S1wbvEuE4JLXbpWJTvTaSBVxVjZ6GjcgUDxLP+OSkXHVnWrAb7ZYeM9HrIztkY9xms/oAzZFFI1GVJoNa3C37SITQYafY96uDo0ZBDhpXEoYA+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/D636UeQds83opatpXpaaOk094iCW8pTpfXOJWBXNo=;
 b=T2/3PL8vxCkGkrLIYtCPYGfB8fYygKTKcV2tZY/tuSZ+nhwNqf/gWbzGExCPVj0Fg4WBJZ+VuW3ohttApAvGfFaMAhFR9T4bcH9MeuijNFs0P2RE/2LstNbodh8Z/bR0eC/Lu/FvQ+xxT4qJJVW8CLijEwbNV0RE7293JIgy0Z8XZKKDw6SvjdaSo9ebWnWUBKrNIS91m8XbdYWaIhgeGvc+aSaZoeVXE+3qixyFU4q4hg+ISVA4ZL6p+PqCMOOH81rWtGYng2xTaEU+LpwySHUoWq46wB2cUQX1WzPE5ork1xDRO93jBca8MWSk/268GhdvQxzgVn5uE73+KQzyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/D636UeQds83opatpXpaaOk094iCW8pTpfXOJWBXNo=;
 b=gGj2pLzKMMmnYyX4i1owRhVkR3a/l8zz9Lvl3fvaN1x6C36zYYMvvfJ54MLhHXOJ7+9DZdtjz2n/Nr1xCuKoqTZoV3u0xL5/Jv0s2dGq7hsK+wxqTJ9SBUqPUF6rKSl5VoRGxILN4Z9mX806PSvZOfrr7HDQHDgxlVQeXLCYXeH3dRsNCeWI5Nldeboah6JQyzTqZ43rtRnoJrSXWJnTKlpaNOM33g9s//gSuxcDX+FPt/lvsgI/7uLGoP2q9ijN0oDv+pYVtPfShIMjFVA+OOGl3by0AayhcYaMXcsHGL+b1peqISY6X04vPZOinqLRRcpFrmdeqgrlw9ENl31hAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DB9PR04MB8219.eurprd04.prod.outlook.com (2603:10a6:10:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 02:36:36 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 02:36:36 +0000
Date: Mon, 23 Oct 2023 10:36:30 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 bpf-next 2/7] bpf: derive smin/smax from umin/max
 bounds
Message-ID: <ZTXcLmmDigWE9dbs@u94a>
References: <20231022205743.72352-1-andrii@kernel.org>
 <20231022205743.72352-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231022205743.72352-3-andrii@kernel.org>
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DB9PR04MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: c90a4535-bb15-4fba-c142-08dbd370e0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WUYjOvdHHcKjme4Dprf2JUZ/is+bFOvTC+sBD9U9zVcnTHyM7Mph7f3LplMlrS2y7iAo1CccIEh8AfOECN03rLE13YGaFKjZvDtcsx/wAPJ4AHAMRdejJYWSf2hggYhS2C24ekIdkTSmwTMCQnCVMFBuoSsuEeFEvKmytIWS1tRRIubI8ptSXtm6SF7zA9JNMzKYQbgP9E2pRajjSCktFhbAP174qZtHKb3fbTXpxCYfVe/c5427488eik3fBW5HnVMOUfplPZ9B6J5P1y6+jvQQJQiA3MRcQRVHHwCTrktb7TYc0u2GEvJdXPoRGV38jR82307NVEXUDjbK2V6NdETW4zhq/uzM2quJlgWsaB/zS6NMAD43G86VxW+9uxeIOZtKaR+5GURDI/EHt3gYaRSinDxpSVeEHAKCiiNLeB5kQaUE8IZOMZrXUZyP/8hipDv2HG7cOPjafepeMGUNDPyhv6MVfS7HhGPvnK/alI4h1mKisbc6G5+roWxp4jmdtf9YOXxW7MqhEuXGTsZkLOlBo4ACRLW5fh/5QUUw+lUdH1JAlpvnZQ7h+Ryk8zqj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(33716001)(38100700002)(2906002)(4744005)(41300700001)(86362001)(5660300002)(8676002)(8936002)(4326008)(6506007)(478600001)(6666004)(66476007)(66946007)(316002)(66556008)(6916009)(6486002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEhpQVdSbDhIdkhERmMxMGpPbHNNYk9QdXBDQUV2Vk9EZEdkcjB0V1Avbnh0?=
 =?utf-8?B?L0oyZk5WZnZYUnlESEdWampmL1I2MGd6VjkxV1ZEU0V5Qm05MkNsd0xzSFM3?=
 =?utf-8?B?b3BId1FKOVNRQWl6Zi90T2xZSktva09JTUhpeGRIb2VpUldubjJtbDRzNUg1?=
 =?utf-8?B?VWNsSENMYmhUdVY4NVdydDIrY3M2QVJERk9qNWZ4clo2cmNaamRTMzJ6UTlT?=
 =?utf-8?B?eUl1SzNBa0NRc2puVTJmczFqWkVSR3FIMGRRclVvUDVuNDR3S1B6dTZOOWZ2?=
 =?utf-8?B?OFZGNklDdkFJWFZUVTNlSVBtQXBydkh1QnlYVHFtTytnVGE1Wk1DVDk4MWN1?=
 =?utf-8?B?WlRSdG1LVXZRNmxDekk0UUZsd29HK04xM0g2a1VyQkxMQXVGclBMWXJXS0tB?=
 =?utf-8?B?UWRzeGNHZFBERk8vVkZHM3lRRmk0Z2VRZktDWFVsS0YwVFZ5OURPczRjdGVr?=
 =?utf-8?B?TXh4bFhwM29zVURqNnpWdEVMdU9ZZVpHVnRBYVMwSkFHU25lU3g5c2lFQUpC?=
 =?utf-8?B?OTRnUU14ZUtQenlQOUpXRVFBVEl1QXR2V2dVQ2F6MHZ6cnB2QUxFUHdGbnBo?=
 =?utf-8?B?SCtKczhOTmxFd3JDZjRnVENROVVSQkpZNlRyZ2trYnFmL3puMTVqMGZqTTNB?=
 =?utf-8?B?MEZ0ZEdPbENBak1Pd2t5MEtlcUpwSHVCeWYvV29rejliRFZVNnlMcDdmVU52?=
 =?utf-8?B?YlE2Uzc0UDJqY0J2VjBpOTNNc3ZSa0poelBONWh2R3pGalBGd0o2dWV4WUx5?=
 =?utf-8?B?U3BrQzJtcm1TbmR5T0VwYlhZeW01eVB0MFVVRW9HQ0VIRFdkZkFZYUVCVzds?=
 =?utf-8?B?SC9hYjRkdFoyN3NCWmNYcHhLWllIRFpMUzZMMytLcW1YY0ZqRDNQaCtXaWs3?=
 =?utf-8?B?WFFwK1dydFFLRnYvN0ZaWGxXYWpUcExiZWxLYzVsMlU1ekcrL3ZYNUxkM0Jq?=
 =?utf-8?B?NlZlR1dwK1RmMndMY2tLOHZGUXpxRVkrZnVwN05JMW14QWFqbG9kWFhHeWU2?=
 =?utf-8?B?TWF1VHhPUjJwVXBBVmxwSEZUbEhxbzJVQ3BOMFFKVzVkQWsxSm9EQjBPNm9C?=
 =?utf-8?B?bklUbEQ2dGVObE9wbkNxUHlqVVZwNlBuMVF1dUtPR3c4aUthQkNYbkJJMFA5?=
 =?utf-8?B?K29zNk1xNmlYV2VvSlN2SndiRlBpbnRwNGt2NmtvUEQ5MHVOWnRqWWczR1Ra?=
 =?utf-8?B?ayt0aDlEc3NGenlJOHhtMThZa2Y3YksxRzAvbGtoNGRwM0kwbGlWbHhHOGZX?=
 =?utf-8?B?UFkyQXNabzJpRStvTUhodytSNWQyVFE0dGZRV2Ftb3ZJUUdLZitQNG1vUFQv?=
 =?utf-8?B?RktucjAzNXpBTVplUzd5YmlKM08yaEFOcmVaazVtTmJkbnQzek1GVTNobndY?=
 =?utf-8?B?TTlSUi9YbFh0NnV3YXY1NkxSRkRpNXFKcXp1cG5yblFNNlFHQmFxeU9Uc3Uv?=
 =?utf-8?B?WmNrOUxSSERMSlRXNldPaDd1ZFdyYWlQeGpnVHpPRHI0VXNjeGdDZGJEZ2tj?=
 =?utf-8?B?V3E2S3B0WHVFcVBEbDZBUnBFZnJMRG5TMC9JQWg2QThsemFkcU8xejdKRlYv?=
 =?utf-8?B?TzNyZUxkb1dTNzNTVnFOREJMZ0J6a0hzV1dTQWJlMk1JZXppR0JPYkVreVhM?=
 =?utf-8?B?Ukw1NWw4WlVCVWN2Tm9XdmRHOGdBMDlwTXhScm9YanRnZ095RUZtTHpDUzdR?=
 =?utf-8?B?UDAydlJ3QmJGUElZME9zZStCSm03YUdFT3huSFExL3BBbWZjWE4yTklLZzRr?=
 =?utf-8?B?ZTJRNnlGd0piQWE3amdsVzYrbTRGMmtyb3BBb3h4RFpQUGVyUEFocE9DZGx3?=
 =?utf-8?B?TXRKdnBYZmlvMkNlMkszL0srK05aUmhQdnRJTjNUU2F1RFB6TU9kOTZtZEZl?=
 =?utf-8?B?TS94MFBzZWlMT1JnQ2JnV1ZLbnVmNUR6VUNVd1k5T0N6eHVGbktTWUh3cTB5?=
 =?utf-8?B?Y2JmT1lQVjVhSkhYU1FFODI2SFJYakVFcUxzV3B1Mm5IZXdRVkJkN2hRVEhZ?=
 =?utf-8?B?MDA3Mm9OOHlZVXZYK3VJcElKSkovVk5jK291M052c2hVOGNOQzdzek0vanIw?=
 =?utf-8?B?UWMyeW9PdjQ4UXpEMzRKWld5VXh3VEJFeFlTL1REY1MrUXdWMUM2bmg1NkM2?=
 =?utf-8?Q?j73c0Zj0bXGVH2Op4IGYGzypK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90a4535-bb15-4fba-c142-08dbd370e0be
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 02:36:36.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+0nMyiogtb6zE/K5xRzU2I23NX1rsMRUeLlsvOjftrYz4AFh2gummpktYFbcGqKuhbShbCqgIDq89TJA7oMmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8219

On Sun, Oct 22, 2023 at 01:57:38PM -0700, Andrii Nakryiko wrote:
> Add smin/smax derivation from appropriate umin/umax values. Previously the
> logic was surprisingly asymmetric, trying to derive umin/umax from smin/smax
> (if possible), but not trying to do the same in the other direction. A simple
> addition to __reg64_deduce_bounds() fixes this.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

