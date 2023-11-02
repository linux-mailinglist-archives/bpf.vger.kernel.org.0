Return-Path: <bpf+bounces-13959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58A7DF61B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AE2281BA8
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC7B1C29A;
	Thu,  2 Nov 2023 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A8cM2dSy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFC19BDE
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 15:15:50 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5F2184
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 08:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UljAz4n9L8Qk4yTDST9ReLgR2XyTxalPSRMC2OZEkjMcVckkmKKQFX/6xXTxHOhOUfpaNI9EdAYfbvrwWWZpIkd2jTuH3UTy2wb+mtHAMAL2S12woBSegY9yGd0SaEfJJI2RHbIvDC4twaVPNG6oLLfCqKfN7HD3BtELiM1pRasWm1rICx2X8igwMTNoupcR3DBT2epdF9RYrXyWZa8GaIXJ5oVBAgCcDOlYlM6PU8nY6093Ofb47Ig2cp7gBO4BsVdxfJtm6C37vIZeHR/MrGyAk93LDfcf7VJyXuzPdOY/xcFMWj5cgD175jpBSzzmyJH5TQw6oEKO43JRWQ8xyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1IeN6MkTCv7npJcN43JsILR7PKAjtag/gVYaaoPox0=;
 b=AzrYeAH3GwrulVe+up23nTAKbV3hvoIk4+tMuyabb77BwoqWQALXRXZBHbH8XK1UTzU6A5LOZ60IrIz0MWkxDb61bIfij1NSyqXPNL4M3Oku45qz5ArVd8kx/x1eb0kpyx1UEUHq3wHm1zwjOcIyfWXSfl8ibi0PS3zv2d2vwzvC2lKkbslIzRjyh3hWZ+9NWOdlRqcZMuOFPrgWYKjXzZQiFd7oGm5upu1HKtf9oKph4nTjQK+thXgFzVZKSnuFTSKXE7cqqXnbMT7im3NwdEdwjo9r2nlSqUQOFCJoIH+FMR5QhkN7NHj07qM57Mh6WyD9Jpp8a6/0B1GxPW0gpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1IeN6MkTCv7npJcN43JsILR7PKAjtag/gVYaaoPox0=;
 b=A8cM2dSyqhoVI0dYnhmVYVtxQmt3PgYPad9XfqVvJ6FIa/KM2zIaZjgQdeVeRW80KGwE87BZobus6pDqHPP5qWAbgKtOGpPl3LMUeUE6GZwRH0yx8iWeyM+lkrtYi3ITql9ntCrmWa4NZuJPvSIfe8+0aBRGVNWx6XYf9uFNVR9GN/F4NiJpbey2MUZDEyj7IrtPNZPtkAXEW1N7TMUPa8qMrQ0b+uxViTJcWs3P4ama7Gf5HCZo6Dx7XIrsEbAvOBFUPzbSFm5VN0mUT8O0UFncdiUD5DSxHFlP635BVKCeDgNeLsBpkIBfI7jOlGUXFSJj9HGWfmG6wRDs1+iAZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 15:15:39 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:15:39 +0000
Date: Thu, 2 Nov 2023 23:15:30 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 bpf-next 11/17] bpf: rename is_branch_taken reg
 arguments to prepare for the second one
Message-ID: <ZUO9EmFMTSEuMtA7@u94a>
References: <20231102033759.2541186-1-andrii@kernel.org>
 <20231102033759.2541186-12-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102033759.2541186-12-andrii@kernel.org>
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU0PR04MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: ec144edf-9f9d-4067-a710-08dbdbb692cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F+/Jt/xktsVvCLwgVBcQx4MvBz9pvN08YoEdPdjw+OL6e9k+qyY7Ww+dZLKdtyky0AvSPUZb775T6UnGH0j7CHJ7RbqOQ+8lVGXRXlfUSGvXvrw8JrQFRUGhFPBWygBDSq8Lv6zXF3DW7qry2Tc7k54kJwdcDrnkpjyqShdviNjTq8FuV1lClUY9Ig3Yb4G2jf4wrn+ymr0xDYq7aReohc9cuhkX/BwR1bOWdT27uE5MBdzbh/bFYNb3o68osXmXf7SYd8xLZ7lvBXBgBgjFgiXRHikT+uSYmPTHnp0NZ6K7RUNHOUuO2F059HglEaj3SbG7nTO7X5ii24WNnrmzPU/SocX62wv26xRQNslpLFe9IoboVdDNMfHeaKe2oPDEfcYxo0uMDhbqvdbqq+EQcV0GXkaCT+YziXYo1UXioTweCq+R0LaTCtZA2SpM5aIAT/PLN/WCPy++d9VbLDQM6TXzxBOSaEfiG4NU5exHkPIZwWOVIdFeiA16huYBQlC+JU7oy0cmGEvx+bQHf38kD7MuzaJQGVZ/FV2n0cDmGxDFUn1h0CVos3N/dGdizCvM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(66556008)(6916009)(6512007)(9686003)(33716001)(66476007)(8936002)(8676002)(41300700001)(4326008)(6486002)(2906002)(478600001)(86362001)(558084003)(6506007)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWZFb3kvcnlySjZJcWhoNUpKc1BGWW1EWGRGYjU5cDlDU0ZHNFYwT0xvWHBG?=
 =?utf-8?B?SUYzSENTL2tMUVoxYVpITU16Z0hNd2hPQkQxdWg4OXNIMC81QmlGbXRTcnRT?=
 =?utf-8?B?S2o0Tk5WSEQ0dGZUMk1nSXp6c2EyY29CT0JXLzdJd0dEM1MwM1MyRi9rWExw?=
 =?utf-8?B?Z0VZNTNJZG5haThRTWpzVTNjcXNqaXNBdkpWejZnbWF0V3JBNk10aVFrWjV2?=
 =?utf-8?B?djJWcE01N3dxR2ZoOXdWNmhndDUzU0FvU1o4cnNBYkVxcFZkVElUTGhpOTNE?=
 =?utf-8?B?cHRYUWRvcW1BeTBuNU91Unh1cFEzeks5dVNSS2h3QXNQdjE2a0JNVzFNamxn?=
 =?utf-8?B?R2hRdkdWcHFaNzdQSWVITGxyR2JKNUM3NDNFalJVdll5WXNjNkFtR01YdmxW?=
 =?utf-8?B?UGNkam14V2hSWlIwazhzU1VnVHFlKzJBT1ppYUdPVGxSaFFkVUgzWWczQTE2?=
 =?utf-8?B?dkJERm5SRU9mengxVWFlemxnZ3VSZTVlOW03NnJkb3Q3OXQwUG0rMUkxUlJ0?=
 =?utf-8?B?NXVWV29uaUo0V2tqaTNzdmdIZDhUOWUwamllUXh5V3RWMmdvVUY5QnVaVkpH?=
 =?utf-8?B?aEdmNHRkUlBiMU9WMWNuSENmeXpNMmFodTY3UVRQc0ZFYjBYVXk5U1dCUDJH?=
 =?utf-8?B?eVR2Q2g5ekpLUFNqempqZUYzL2haSDhDRWJPWTZjaWZJTk5vMHdJcGFMK2Zm?=
 =?utf-8?B?WGl4cUxqZ0JodWZrWHkrd1BPNzdUUGNhQ3JJcklZb1lpcnhyclkxT0hDOG9L?=
 =?utf-8?B?WFp4aVF2RXJLYTJ0eldibG0wZzRXU2x3YnYvTGc4SWVselpnVW9UbHZEeTFS?=
 =?utf-8?B?RmxqTkJlZUJOcmRncTM3VHNMOWhQZVVMZFlYd1JjYUs0QVFZRmVSbGdxVWV0?=
 =?utf-8?B?R0FWYXMwMnRQd2JmRlk0d0VPT1FpamhLZjl3RUNvSU9Vc2d5cytTNk9vVTJq?=
 =?utf-8?B?Njdjc1h5T3VKL1V6VHFyVmY1QVhlWTVIa1lodTVoNmlqVXhtNzErYkVBMVlX?=
 =?utf-8?B?bzQ1YXIzWkw4YloyaHEvWjFhR3lIZUtvQWIveTIrQmVJSGlyK01MMUs4WW55?=
 =?utf-8?B?bXlRRkV0RDhZV1J3TWhvVGNhakc5czkxSWJlRUtoVlBha0JteHJCR1g1dC84?=
 =?utf-8?B?MThJanJkSlFOVVY5cjVvRE14alZYcDUvbVBmemNhOVczUldLb2xUQzA5Yjg0?=
 =?utf-8?B?OTNFN1BmdmY0eStEeTkvSThENVh3cWV1K000VHpta0lkZkNQZGxsQkFmWVBD?=
 =?utf-8?B?QVF4TTV4UzZ0dFJOU21tcjlQYjJYMEVNS0JJU0hETTdiOFZHbGlqdVNsOW1q?=
 =?utf-8?B?N0d3K05lSkJGNUR5OE1yaW5XRFpjME5vSHFLcWRXME14U0ZGOTlyV2hpSTBa?=
 =?utf-8?B?Yy8yY1hUOGJhVkcwVkNpVDYxMUlWRHdjZDYzMkhjK0Z4TWRtcmZudWNaNEhj?=
 =?utf-8?B?M2NBL0JWVGhGV25wWFdOMXNZU1IrVGcvTFZ0VFcxNWdibWpLQytTVWkwT3NC?=
 =?utf-8?B?a1lXV2Urci9FbDJoOElBcWVpSHZFNDdIMzdmMHNaald4bXZ4ckhYTkFNV3lO?=
 =?utf-8?B?bGR2QlJYMEN0YXR2UnduTm1DWnNLeEpFS0h2K29EemVjSXgvK2VwNDYrRlRw?=
 =?utf-8?B?L3ZHWHpBdXFmK3U5cmZxdU9wNUxsZkJsTU81MW9RRGxnVms5SmVocnJaRnNx?=
 =?utf-8?B?MlFhWVNWenEzRDBWSFVLc2VrcnFra0V0cXp6ajBiMi9iZDl2aXhXcGJzRGRS?=
 =?utf-8?B?UVM5NE9ZL2xhZmR1dWNETmxjU0g3Zkd5ZFJhTkdpR2hzVEdkTjY4S3J6Sm5y?=
 =?utf-8?B?RmlEczUzZzR6THhOVlQrWkhSSE5qdEhaSGI3cTlGN3c0S2ViN0IyZUNQSGhM?=
 =?utf-8?B?L0l1c0dEOUo5ejZ0SUhLNFhjYm4xdWRXT09lK3NhUnMrbUpEdFFHTUpwVTVK?=
 =?utf-8?B?QkwwZStzOWZUU0NacVBxb2FXQ0NlN00yNFZ0Vyt5QkMwc1Z2OE5TVmxMOHV1?=
 =?utf-8?B?T1NtcTlTOTA0eG9KRFlUMUdOT0p6WjRaSzF0cHNqVDF6K0JFZHhXUG1BcVQy?=
 =?utf-8?B?VVpHamh6Q3owOEdmaVV0UlRBcWNnVXZhQkE3WnBleFNuSERjUlgzT2V6L0tU?=
 =?utf-8?Q?2A87wHKpl8F/X2YuYTKwatbUO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec144edf-9f9d-4067-a710-08dbdbb692cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:15:39.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USZbKSd7e2n+are2xuAm7imENJ/3wKTYHnrccE83kBtS59ezeJFawzhMMeRqanWeupRL8bgdI0yXhAiR+EXwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496

On Wed, Nov 01, 2023 at 08:37:53PM -0700, Andrii Nakryiko wrote:
> Just taking mundane refactoring bits out into a separate patch. No
> functional changes.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

