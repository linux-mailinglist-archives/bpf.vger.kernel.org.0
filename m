Return-Path: <bpf+bounces-47137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C009F5741
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 20:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2019A1887C4F
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 19:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4962E1F9413;
	Tue, 17 Dec 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IcTLwFYP"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E3148850;
	Tue, 17 Dec 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465219; cv=fail; b=kEEekrSNes7jziFjAVHW/A9g+VQT3saWVUAYjey9Fwg6omvH2UJiduoqkF8TV9KDXmbFouZEZQDd7QuvpEymsWx+gKLtIFczPBH8Fqpuziat4uaA/VcMNJ/+POsDInonRf/vuLaDzSc0BH0QPS24//bKUd/1FW7qKpUNePKJljE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465219; c=relaxed/simple;
	bh=Y4Rxz5zJ2sYeZ1brPNaeRJljGAqImaIviwTSovntllw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gk0LBd59LoOHEGkdrlJ2SerA42+OL7LIt/aAXF84/TrPY/nnA/aYUAIhmSsLA2szfK0KEtSysFO18JD5Q1x/UuppWxhJBObL/bQQHqwsbQZAYa5n7PBrSYknEUBZzvm6mFGANfbDZDL4MNfrfrDmYklRRhnfEFNl8EwXGKYVt+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IcTLwFYP; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUo3VTQA2H3POW2ukB8LITvllNTKXJB7c9gXOh0rPwG8aYwY87z5EwjE3C32muWikydu7gRatCEuskbKKgDxv9bq9EUpWcfq+/DBaTwvezHssvkwevo/XVeil/C2updbD14urcVB9UJUwL2qyA7DOzsPkXB7L2/VQS+8phaDM79oW+dN7a4ajZpElNFo5KEapli4hxdgPl6E5ktze4y+r8L//xO0AiZIaP3RCXj/mThp8CEMnjIf5KoXsCtz8qWuacdrWtidi/+DTLNKMFMiYwPRfmmylNIgMvHPEH8tcr0fH89InHOqspvmOW25DgbWkN80LAk8yaP+jx4hiL/Wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw2c7sjvY1sxhyCNtcKzHV+EeIUHz17x4Gjqa5mxVD8=;
 b=BVwT57NArO0oYn52AYTTXvcAxRKkn+dCi3DM+32Wc2LrxGKJoVu1jgHil2B+zi3n94rcZdSxWzavusBLCwjpzBj6q4pxpLZUowzapPdF0qAwDvvvW1gBXZp+2AMawYWJYnMV2FKz87EvsyJkO83L+8JsRb/cPVDSmdnlMwcDrBicUg/XDaLmI8LsaYstGvZ0PdrdZPlvZtVQcaUBGpbtdGNjb9PP9hJeWSw/7W2iK8q2TM/ICTAzXImIJu4B046mL4CMRqryhPc+6fiX9UTPI2dneTtDIctysbZtvAVk8Q5euoH9GNMyI+4z4IezA94o3IfFtVv6eQRMtoy9NVAD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw2c7sjvY1sxhyCNtcKzHV+EeIUHz17x4Gjqa5mxVD8=;
 b=IcTLwFYPtGdrlyHgqnCtKQly3wRJE96gJndUeYIksUe0wynpgtV+xrf0FEM23PXki2Nr98fFVEkLkLFWkb6KVcLJdusTOrtOC4IaKEIfBXKVwqKB/FwP+N8ZW7oCKCatCJSADoY+zQrXVdWd5kTZ2YQCCsipjo80rmYq3PpnPyegDWnVWQP1VdYv/g8/n9dgssXKvfLOEcQ35qaR3YvH9cJ/AANd0Ac+hSd9qPWnsjnLPXJBWwE2FncD5MqOeg0SVYaFm3f4PN7NfGCBPKn5rOMC4Duf0IPzpUo3lyeDCVwqsOvuOX5sgkid8YYjtvvT6Qc0pnxQQBoTWjE4vWRElw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 19:53:35 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 19:53:35 +0000
Date: Tue, 17 Dec 2024 20:53:30 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP
Message-ID: <Z2HWuv6o86W5yY7j@gpd3>
References: <20241216210031.551278-1-arighi@nvidia.com>
 <CAEf4BzbKZ3JL7FigJ1aRDJSiRYBA8wYjh0+TYNfnsNVHd30j7g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbKZ3JL7FigJ1aRDJSiRYBA8wYjh0+TYNfnsNVHd30j7g@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ccaf82-5a76-4ca9-ebbf-08dd1ed47dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zE3nvzrKjU58mbEyCLrKbFLLeKhOysTdJaub4/nrfwxfYFEyHaCxMF3wlBkG?=
 =?us-ascii?Q?0XGzsVomKkeXW4reltwp9bxBrewqh/NwBa6PVPTsckvzIstwy8O/RC5eHJhM?=
 =?us-ascii?Q?mT2wH8urGVynASB/W1EKeLEljRYTbxhMNNRfG1UClmwWHY99vMMj/UgrQUc9?=
 =?us-ascii?Q?oaYr9sUvJuWX3Vu9fvJUWrMNbNvxBWlbdmwVjQv/QwBSo7AP2crxRMMKZiPT?=
 =?us-ascii?Q?nuqZpnl1GHMeTwVpzBTI9LY7YNG8I1HF+M+khpwF9fXvi2IetQLmov+Vxf04?=
 =?us-ascii?Q?QxbAeLpJ473xmHZR+KpozVhvPllKkXEQCj7qKk4b73ybvgICQTw9nQ55z8zI?=
 =?us-ascii?Q?JNzYY1N9jyopv494R25+dq5swgU3OUE7+k3uoEbv1FHV3gwPYpB3OuQ3uTh5?=
 =?us-ascii?Q?xUvlebrYqnK4OEOu32elSiq1Iam/OpppAQyj0fBQbcXZnYFoxnNt/AuHAyKJ?=
 =?us-ascii?Q?EkpbkTZPHJ76qAHs+cOxYZ4CyrZL1pvs70uy8CBTWY+whnhUVh+oMzkJiLIS?=
 =?us-ascii?Q?IbwcQkw2ifD2IyXOxKg4yPcgdNY81KgUmBM8jZ4DzJUYn7y+1e6gho2Yusjd?=
 =?us-ascii?Q?q5hbVl1ZeWojlUjOW4h+LxRNYGeP1c1ju1EBlpBi9SqKkHZi62jYoNcWPwWZ?=
 =?us-ascii?Q?y+QGorLQCf7ogk/x6+wPT8gl5ycyBM3aoSDbuOHodX7s2qLT0StGv90d0Skc?=
 =?us-ascii?Q?5PwDjYrL9Rlo4miFTmaK4+wGaWZlbdwMBwhVwf2YERP4AKhbK+CV5qYCkX9o?=
 =?us-ascii?Q?WiVNY4FzQzxoJz1enlN1XrMKfKVh+PwQO6vPyasO6yZJ63CpROnXXL8FnO3w?=
 =?us-ascii?Q?VNLNdMcejC6D3bFhSfALJjO935oEgegd0nIlbbcTSHQYkvshba++fAaDLTOB?=
 =?us-ascii?Q?UqCZPW9x5FEv76TSVTZgI+zeJ/Fs+ohCmX+iyx88hI0Uzd/wgGPSfTGv9p0p?=
 =?us-ascii?Q?0m5CGkc14zpRwZ2UUk1RQLpvJc0fjI0oSCxp6veuWZaX2rjmpjnhjq2kESde?=
 =?us-ascii?Q?EN0hupjLoy5d+IbtYxWjQ26gWuIAVdnvuwHBbTfcVEeDH4iLa3XC1E/wIxtG?=
 =?us-ascii?Q?48jGc5EJ9fwFKKPs4A0aHzDeAyGcWUnA4EvYNMaGalpzx47SSTsgjUEcXf74?=
 =?us-ascii?Q?06lMybKuqgjta+KrR4bDXK7Cl+c54AEQl/LBjslgmWo15+kLn7i3rXF8/m4J?=
 =?us-ascii?Q?1OqZZQ0Nc0WYKysnXoEcX/JKTodm5YjAuNm0TSKYfdV6pPMlWZrFM61pKPz9?=
 =?us-ascii?Q?G+ixac3G5O6llJCdOmEe2C+T6Mnr03klFRXCGIFaPBMmYM9FRwKIRZCcMppw?=
 =?us-ascii?Q?x6aVKz4dEl6GdHxlXLyPRiCC28xdVAe8DlD+wo8wjdqmSRRHzalpTdNYH+2q?=
 =?us-ascii?Q?2jmNkuFpmCf6934qXpRXDjF5urSu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWFOPA05ledsfXGQjsuZswGOcyvgWipez2/3ttsVtazlyPiMXpAARb7c6ff0?=
 =?us-ascii?Q?NArs7h8uLELYhicnv3vDL01HC9zCSStC5/yduubGiNNQhlCD3l6DXvwJ93Dd?=
 =?us-ascii?Q?LcL34OnalfVH7CdgA7vIQGj6+azbpqtVC54LmHwSYP8QTc4DnWbZM8lZe7YV?=
 =?us-ascii?Q?l5wjyTWAfL3WcwwSdESEBABl9UhNkAndP1BhC8nIGgHHkZ1qm3gamfMlBU9b?=
 =?us-ascii?Q?lON8HcWvWzM8jBsxOXMsPkksb3SmtOHyUNxrS/2Rjv0OSwpq0s+HA9Qhvfl5?=
 =?us-ascii?Q?+BSdqzGd4RO9vZDvdAkr7/SitKxfF2/8Typ4ypmq2r5HefWSyhv6fFVqfGOV?=
 =?us-ascii?Q?IP4Ig1khHLx7xYqNQ01UmMdT+3ntCEENsSxXu3PG7NN/2+FiiX2Hd743aGSS?=
 =?us-ascii?Q?EWriwA07vpgrW+wZyTz1v4yy0R7veghwVxeZHD+GqNgtwLWo1xNAzhb+wTgn?=
 =?us-ascii?Q?YDtNMydsGXxNnxOp+lpXoGJCJPUtReVSkR8ZRz+hJ8OokrBYjIobIAVn3Ktc?=
 =?us-ascii?Q?x6mesFyVXY5kYN82qJb8jmOvqiw4I4BzOcmg0f3gVK+ufPMQn8RAXO6L7Yz1?=
 =?us-ascii?Q?OoccTUOo1X7ULelVx4VCJ7srQBrxBBYFHJoTR1Pl8aoxX5qOBUu3SckQAmm7?=
 =?us-ascii?Q?fC+H2PGSK2vbAJGFLPmCtloZJNjz/OcIu1jIqAy5HzzFwrbVXZEdGcw9w0Sl?=
 =?us-ascii?Q?sROo+hRa5/LEq8FAtIrMkV0N7iIryheqGucWtitf0v5a24H91dVvvX6UO9Bx?=
 =?us-ascii?Q?gT5M+766YZP8HXRj3XNsiLq54uHd9UpIZUfHipjoDBxhFzP1rFxShRZIfNsN?=
 =?us-ascii?Q?xj3uqYwZds/iMdZKLPzLB/QSYmSbZtbK8hGf3is09blKOER806spx0hOFx8W?=
 =?us-ascii?Q?rVfCDrvl1hNkF8KjAeDOC+5AIhJxQJZy8mtbkhwIcHaY9jzeAXOeDFhPA41o?=
 =?us-ascii?Q?/X6omgE/yXij6qrVtP0RvAl2DjJ6tfsh1b5iRIF3mHYPm/ugFKwSAacX09fC?=
 =?us-ascii?Q?KBR1CShCKlebcw5c73GMhh9nljrZMpDuIJLO09Ep73pP0hZDzYL3PUq1Hn68?=
 =?us-ascii?Q?yN61ZvCuSb0fOp/oX+0fuLYiDMSnmm6ky8Ayr9b3GFd07ySgR18KtMzB87SX?=
 =?us-ascii?Q?G5JwUgfLntSsiUk8Oobrp1i9IdbrM6BjQhbD33auzkkF3gow98W+lPRS19lF?=
 =?us-ascii?Q?F3tZp7ORSJ1nT+yfCuNus4CZPbVbR9vQufBSJZR7kesGCZm+n1aWopovU5lB?=
 =?us-ascii?Q?3B0Jk8wGWFFhvs55EMhFDQNP/zkpjetkt914kxgHO8VYDx0iABVl5feDNskN?=
 =?us-ascii?Q?do63ZyN+uZ0nEfZCnnrgoGUOrZ8xn78SFajMLu+32qeZ9hAHfQkFWEuuygCj?=
 =?us-ascii?Q?YAh2lXi2ODsUeA32tIilbQliyA/P4AcjpmKVWVHrP9WtU0/itaqiyV/u7cAI?=
 =?us-ascii?Q?tnTozAN1Ni2e+Rx/q2DFSf0xilDxPfiZl28idYSPno2c9mqUhmt43x6wN1gf?=
 =?us-ascii?Q?ekzvD3gTAiniaHBm4+V6X3XP3SG9e7f9CLRHnsU1KhZFFNAzPQmKmjnFX9PA?=
 =?us-ascii?Q?Xmx3s0fBpYOA0oe4wf19teGpszG3GIQxL8L4RJ2m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ccaf82-5a76-4ca9-ebbf-08dd1ed47dfd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 19:53:35.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cnns8qm+/5unupYbym+SBZo8WXeTBN+3PA3ATLKYUe4YEnegUY6cBtvWzBGboz9OV/P2MgnVqLZMPjywST76jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

On Tue, Dec 17, 2024 at 10:38:04AM -0800, Andrii Nakryiko wrote:
...
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f7f892a52a37..761c70899754 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21281,11 +21281,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >                          * changed in some incompatible and hard to support
> >                          * way, it's fine to back out this inlining logic
> >                          */
> > +#ifdef CONFIG_SMP
> >                         insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
> >                         insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> >                         insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
> >                         cnt = 3;
> > -
> > +#else
> > +                       BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0),
> 
> um... shouldn't this be `insns_buf[0] = ` assignment? And that comma
> instead of semicolon at the end?

Yeah.. my bad, I tested it with the wrong .config that has CONFIG_SMP
enabled.

I'll send a v3 with the proper code, sorry for the noise.

-Andrea

> 
> pw-bot: cr
> 
> > +                       cnt = 1;
> > +#endif
> >                         new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> >                         if (!new_prog)
> >                                 return -ENOMEM;
> > --
> > 2.47.1
> >

