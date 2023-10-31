Return-Path: <bpf+bounces-13699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB33B7DC7C0
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 08:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079831C20BD6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868A10A37;
	Tue, 31 Oct 2023 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qH5wnra4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935A10A30
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 07:58:02 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999CFDB
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 00:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEqm3EIzbetbY0YlbPVkspi8LsrJciEahV8OIcLgg0CSog23YRX8DtPEGiNEgMEqKXg8xeypKvRKgadk0/AkQ6PuZMyJXJbPk0+naMB4gvOe25SF0BIlJW1y5IehcnrPvqYwX4wcwky8tvRugfOv7Vaj9kyCjw5sjjr4zAI+T/jtZn7ZkYFwnIiUHvvwsCLS7YHCMwgQkeVmTjZXMNkMaFqZeq/VoDIx8SOY7LL4KnmfG49DNkyi1ugFfZxUjiu680cIiz0wbFJtBfZqxOLgyVKaAV0c3ZWkzAM/TPBaB+kvliRz3l04QNV4+h9n8QAguvJnJ1o+NcFFXL4XHCAM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftyYhOg4tpCa0E0E0u7qjpXEsD2MSri6E2b/HLrDRW0=;
 b=avuMsDjNYjEXeUJcIBF8S44+lR2410nIE7bPiJzPjVg/cWwpa9qaA5U39sVAqpVUi4+fhfyKCQG6viAdZlIW3iX6Ieu/HflghtEy7tJ5axe4xQBA8f1ZhCfDgc3Pc/qhAGmPRdry8A7lfHhVFyGWiFFbYRt5Jr0mYtrxFJ0tEDDi3i3ZH7c74lFmKnhhqZxpapjy+w9v3uKdE7YdV9odBqdyJGAIpHMshnCNiUNs8Bvwf+Yjx3SKdy7rGY9FKhwk2HjUGARpGqPyZtSgFdLF3aTOqPG6OfPFSC1oOwS2xAChGnOarHBZ/PlSHlIgJ5/OasaVw8qZeE09ZtJ2hYmt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftyYhOg4tpCa0E0E0u7qjpXEsD2MSri6E2b/HLrDRW0=;
 b=qH5wnra4Fb9pxKFxrkP2+ZIzaKisrUmd+U6dDzf7zW15csvRSZlJuwl5iqv+8z7LJj/9q0L30Uc4AwoRnfgeEDUnoPO0IRw4+Xs+xPx74rbcrKGx6wUOO1FiDx9+vnoNlhW+dBckRfcgtSmQilABQLULZgbTzTLTVO7HVLGMvxdfOaexCm8uAbkxOBdPKD4eEBO44yth3ewhYC9exlyAyaT3cqQoOCLLr/Hw1sSY17fyizq2ydJOT+AXST1VQGnuQcdDwgemlnyR0ISsNiTF2H2Dzm5GGCZ4/NyI0NembyPxz8WPS74t1slpgzSy9saNbLpZHkZQyS+e1jjH26Bu/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB8735.eurprd04.prod.outlook.com (2603:10a6:102:21f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Tue, 31 Oct
 2023 07:57:57 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.016; Tue, 31 Oct 2023
 07:57:57 +0000
Date: Tue, 31 Oct 2023 15:57:44 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Nandhini Rengaraj <nrengaraj@google.com>
Cc: memxor@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, joannelkoong@gmail.com,
	martin.lau@kernel.org, void@manifault.com
Subject: Re: CVE-2023-39191 - Dynptr fixes - reg.
Message-ID: <ZUCzeInJlQs8L__u@u94a>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20231031070556.400813-1-nrengaraj@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231031070556.400813-1-nrengaraj@google.com>
X-ClientProxiedBy: TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::17) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: e9568ba4-6ea9-4bb6-bf27-08dbd9e71822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dr3POdzZYRoIl6jTorcJVMjM4JJkj3VpeVC3yvQ0krUknb5tsh5GhbIiqhC7l3wdKgqiNbC2wko/Mo7TePQpMHdfquKJSNq/2HMWJwZtekplahO1Ep7Sbc5xMs0xU/zPhqlyP+TgU6BMZg/RDP/EDTGnYEWPDLfIe051TgT051TFqeZhtOrwwjmaoNFdCzubgoVRfUb45fbCxso+Yvv+W5eYOlfLQH6g6yDWM5nBc16YXIxd0RERRNidHk3frwsc4woSehe7pykMHhgnkYCa1bIACnzSok3zKzhtMAdV/z3U/xRBCY8Q5BBv5Ek6SkZaKGkqafYZrbWb+45disAxkDA63cglaHKLmXBEi2G1BCCQ6DtxtoUh6tc91jKcPFOY0sJmP9L9yeghTARDoWxxgr84wgarL1U1GOzuIeTwuTx4ek6vNGALAsAGjDsh3T2k4s6X3BqjvfZWdLzPKL2z0ix8IKtOUG7t3KjIkWFpKK4pZ5hUCs4q+4TOGSgZMP9q2/RZ4gTTaI2TI0hax8o58NHs13H9hVsR5vkcBAHrRtE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(6666004)(26005)(9686003)(6506007)(6512007)(38100700002)(478600001)(966005)(66476007)(8676002)(4326008)(8936002)(6916009)(316002)(41300700001)(4744005)(2906002)(5660300002)(6486002)(33716001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmgxVEJ3Mk51enpVSmJ3OHh3eVovZnZnTnZCWk4vc3piK09IeDdUSU9CdHVO?=
 =?utf-8?B?MHdTWWQvSE1PRys0RnJ1bEExd3BsT0xkWHlJM25VOGtOKzNFVnl0ZjBzM1E4?=
 =?utf-8?B?T3I2UmpoNk9kOS9vcHd2OTljTlY5WCsrN0RIV1pwRE9zR3IzYTVtd2FudFFX?=
 =?utf-8?B?S1RvMXlWMEpMTG1pdjU5b2RJRnoxbW9SRnBNV0NabWU5RU0xNmY2VDllbTdX?=
 =?utf-8?B?akJZN3Y5UXhxYmxLV05FMHVoUjFncm5jVG1OSUh5Y3N1UHFyNHlydHVJWUl5?=
 =?utf-8?B?WG9IYkljVmg5WlczaENLWmk1Z0R3NXp4UjFMaTB3RHRHQzhYYUkvMlZsTDRJ?=
 =?utf-8?B?aVIrRzZLSzJuQ1RMM2kzeVRUdllpbDdqZGI3WmIyaVBuQldyK3dyZkgreFpK?=
 =?utf-8?B?UHVOWHZ1TVZLR0wyUHlGaksyRWxoNzJ6dmZ0a0ZMMXFWMVppZ2kzTk5tK2dj?=
 =?utf-8?B?VzE4N2owVHR4b0FaSEh2N2lFMUwzR2FpQ1dhUHRFUXZZQ2JZekdnMDZzVXh4?=
 =?utf-8?B?ekZnd04zYzlIMCtHUWlwN1ZZRis3OWY1UE5xNlJ5d3pHeGxWT3dPOElpRW1F?=
 =?utf-8?B?Rm52SDJNaUZ2cHNTN21JcEhXUlUwSkIxKzBML0J4aFp2OHhWUU1abVUrRjh5?=
 =?utf-8?B?QTlxS0FEZ2pONkhNN3Y4cHhEVUpvKytDbVJnYTU4QmtyMnNSbEpmWVg1Q2xt?=
 =?utf-8?B?UlFVdDlvTWFjWm9vWGpnNStOL1RUQ3lKTURLbWY1SUorUXBtZjM0Q04rMDhI?=
 =?utf-8?B?YllWSkR2QlVnT01QZXgxeTRuRG42MDIwdEVicmVBMTFhb1ZRaHErQ29qTkc0?=
 =?utf-8?B?b2J2cG9QUHUzZlBDMlBwczFFOHF6OUl6Y1l1SDNpZDhUSUZORkpkdXF1VFB4?=
 =?utf-8?B?M29icW9GbHFscmdrQmFEVjRGVzFXbjc4MUlTTW55Smk4eEFZL2NEV0p1L2h2?=
 =?utf-8?B?QThZMm4vMEM3M3k0VmR6ckhIN3RRWktIN0JMdGVQbEpVZHM5Q0s0ZkdyeGNv?=
 =?utf-8?B?NUJreGt2TzlzWjNpeVpRUWxXRzFTYmxMbFZ2Y2t1YU1FcUYvd2N3NElYMFM4?=
 =?utf-8?B?bzJIVWtMc05CQUhGY0Yvd1Mwb1lodXBRRlhNNVM2azE2WGpyTE92emlXR2da?=
 =?utf-8?B?OTFmZHdWOENrS1g4Um1ZQllObG1iay9IZWt4aXB0VTdxeFBUTW9UZzhBcXZ6?=
 =?utf-8?B?Q2EydlJqeDA2aC9DcFZTREUzR0xodzdXOFBRYXRETURjcWp2SU16aGllYWxN?=
 =?utf-8?B?OGtqaHBMcFNpOStYbEtIZkxNY2cvVUZUc1o3UXlSQnlYTFJpMlRrbTZ6em5N?=
 =?utf-8?B?MEY0dlYrcWVyWFhqNEV2NmpGclJiNDF1R05zNndvUUdRbDI1a0NrdGhhd1Q5?=
 =?utf-8?B?OFE3Z0VHSkVONUpwRk5KeG4vQTY0TkZnQ0dqR0xvc0xDVlFNcEJuOEVyQWRq?=
 =?utf-8?B?MXhqQysvQ0d4a2Z0VW1CRXVLS0YweVRsOVpIVEQ0NDR0TWFWVEtrUGVDVFdu?=
 =?utf-8?B?KzVQTnpLcForbVF6UVp2czB3bStxZTEybHB1ZDFXRW11WXhoc0ZyQ0kvTkVr?=
 =?utf-8?B?WXlQMkNhaVFvcGYzckM0OTViY1JwZ3I5aG9MWndvNjIxbmlmYWxOYXEzNGV4?=
 =?utf-8?B?MUl1cnM3bDR4RkJpZ0V6ZDdtazZYQmFKTjZKVlJkS3ZLbnRQaEE4N3h0T1ZU?=
 =?utf-8?B?WDEvOXlEamdJRFcyeklFWDR6cmtvcmlWcmZ0bElhRW10K0E1MVNXQmo2UDZO?=
 =?utf-8?B?a1NFcXREWG5yam1NSkZLT0xQM0o3UEw2OG5hOUVRUTBueHpnSmNBVDJUQlB1?=
 =?utf-8?B?OUxRM1J2TW5SRExvZVJQSDdJZ2VkOXk4azIzbEpwc20zVnc5R0p2WVN0MzZM?=
 =?utf-8?B?Uld5YTI0RHUxd2FGNWczc2hQcVhCRDFjS3dtTk0yTHZla090TlBHckVIZ1M1?=
 =?utf-8?B?TCtSL1ZBSWZCdFdxUTFZZUN5cFFya09oSnl0dWtvR2pXaTBJTW92cDNGYWdM?=
 =?utf-8?B?cWhqdFhGZy9naU0xRTZIMkc5dlRoRnUwU0xLaTBDdVV4TDNVL2FKNldDQ3RM?=
 =?utf-8?B?Wm55eXA0eGlWcjVtL0ZYTys1MHdvUnAvd0w1Z1Q3MlIrbjJSQS8wSWNIUVZj?=
 =?utf-8?Q?j7qtI88J1B/cy1Fip5CuvF4bZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9568ba4-6ea9-4bb6-bf27-08dbd9e71822
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:57:56.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUeBY7qyGrVaLQfl6c0LctlzKeEeK+OGExTYFME76XduDtOFa+6QAYTE1gf8aIMgLiEaNkk988VIUehesISk2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8735

On Tue, Oct 31, 2023 at 07:05:56AM +0000, Nandhini Rengaraj wrote:
> Hi,
> This is marked as a fix for CVE-2023-39191. Does this vulnerability also affect dynptr in stable kernel v6.1? If so, would you please be able to help us backport the fix to stable kernel v6.1?

I have not work with v6.1, only our distro kernel based on an earlier kernel
(which requires more tweaking since it doesn't have user ringbuf).

Regarding backport to v6.1, this series depends on the "Dynptr
refactorings" series[0]; once that's backported this series should apply
relatively cleanly.

Shung-Hsi

0: https://lore.kernel.org/bpf/20221207204141.308952-1-memxor@gmail.com/

> Thank you,
> Nandhini Rengaraj

