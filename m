Return-Path: <bpf+bounces-66639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175BBB37C1C
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B984C3ABF1B
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B831CA40;
	Wed, 27 Aug 2025 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zl/5gM1M"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780C20322;
	Wed, 27 Aug 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280726; cv=fail; b=CTYlBNA9EW6fnjKuNej/k51aURl/tUfqA7O8C8Trbhle+o9kOH1Ho2FNt+cGEh97gvwhT1clwVhDczYhRWcjknZJ7fROEj0xkNwPdxiG2o7x4Lxr+owJvi5AurgEZszWmw6jDqUk68EOEpKslkIZvtYXGlZgoCV1EpYIg8oNFGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280726; c=relaxed/simple;
	bh=LdrCPMXbU3FM//UKVsZbsNr90heeTH9m30pmOjbzmf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VTR6F3pZsRHpSi2p3YJ8VpliZcivBTiiuGZRymsMDSVs0P+S4gA6bNOk4uMEf1R1ID+vjYYw3rxo6w7PBMKbJd8l4H0C5bJq/SgYZ/ue0rBqRpIjK0aWylhBcw0q9oi71t2es5x0MViiP3vnPQJZedGu1OAOrzpT163eh325aDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zl/5gM1M; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIZaPuPreiIaRU6mVB5liasyNWfQvo0bXwVEvugnlUM3zHFBLM4A4ikM5xLdg+JkxNWNJScV18yjf8MGEvhptYy3s02pOuA26ZVbrgy2TdWSQttVlQRJlFZd8OzpNW0vnqDhoRKd0lt0brk4In1st+oKOZf7xwheikJ67YkZwSV/8w5boUhAyEg26X4KR5a3Rq/i5+c/8eSz7rAqpprhO/ozLH//03nEqgo8qMcg1QyPHDyeJl3VKjJmciJz3VX0jcDNc8syZhhbXdIFLKONOghzABeyovOgdQ+5Q8E0YeYgzmiwOUX1b86cjK9qduJ0o0SS2wGlYPAQi4+yoTBhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IAye6OiLznoRZmaeD1YTVOyshDgY/FS/Feze/KozUc=;
 b=MvMd299QyZeDvLSNHLLa2FMd98MMNUs2f/CPMF13Xqdp1q/fXDFFqUFYbVX63c0uWQmhzp+seDE5xSZ5O5lz4v1OSafXmrGcBfiQ3ggqUzOz/jrSFCyt6lvIfyOYeBrX5lxBGZwSOn7WQXG/SBNVMtPf8ZY2h19bOeNn5yz82xpy9jP5ybxwaHKcMP5ylK2MEH9LSRbKkNAfB9H0KKrgOYV+JQft3T5G2eQ/6qiv/tv411pyL2MGXnKGywN9sWUgeFIcW5uCGJ6Qp5cn/QFHXCj4kBHd8iVgHm5ovIk46ohBFRxxXaiglYzwgK40uU4Ong8r6O+UzYa36wSYyJu0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IAye6OiLznoRZmaeD1YTVOyshDgY/FS/Feze/KozUc=;
 b=Zl/5gM1MBQHbRDwk/RI38LQZRIouED6eN4VyMCHy1xNGQBkQ5nbrIgLxkcEiaeuWvGPoHRav07OKfm43R+dTuT2Lxa2NXxlV0BVOvofWB3dV1P0jTPf8/x0JGucKeNlBnLAwNSCmWIgYH504wdAAbu5KNizKQAx65+8TIyyuf/Jb4z55c1xC+OKH6xRwVl2dMuZIzIufV9l5aVPxHRDNtFTq0//mPU7UbyAanhEevDoUhfvUZtRPzd2QapJLTbGmwQrVGeBRGJLReyot5STyaffisB3Qo7p1DEblAD4Qjkb/DTvxBYuMYpQnPv4X6NZ5Ytomk0fs9KUZJeL9Rj1NIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Wed, 27 Aug
 2025 07:45:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 07:45:19 +0000
Date: Wed, 27 Aug 2025 09:45:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Message-ID: <aK63i7yvJFKkcDpw@gpd4>
References: <20250822140553.46273-1-arighi@nvidia.com>
 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
 <aK6aiEbgYaI9K-pt@gpd4>
 <622cc7980bad96bb2c7ac8d23619da1374c794a4.camel@gmail.com>
 <afd8091d11429e63949a16fc24228078b08c7726.camel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd8091d11429e63949a16fc24228078b08c7726.camel@gmail.com>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 436de7d8-51ef-49ac-f69a-08dde53dabd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGJ7U3hXsurKXiWdtBpAs3qh+priBh8hoxwIG4Ju8aDWWsrjlwyjZK0/mL7Q?=
 =?us-ascii?Q?Pzn/nrEXREdQ4kiJsU/xKlqNw7drwgb8pG4Tx0e1aHGBQ6Tuj6x+hysyx1Va?=
 =?us-ascii?Q?t06Wdsf2EGEgfkBCahAXTUFUv5UpJc0Sh0o3kLnrdBF8bv6YXsos4LXRBCs6?=
 =?us-ascii?Q?G9CJuuXzU0HnZu4gryuskrxor1wTp1dWyq3eTejZygZWVYAkQb554wITUwK2?=
 =?us-ascii?Q?Z5bbUk4ezWOrDosGiPqTRdWa/lBdcMV3bMnob8J2Y2NN/xKrdtaorEoSu2S7?=
 =?us-ascii?Q?8GupQKqXPhnz13T6ZQ86/Yth3X68QVV0L5eP6deFJZidUqZWoKn3VXmzS4e0?=
 =?us-ascii?Q?M/Wqw7tDsNDuS47wPPNkLz9i+Ke4gg3VAOfqRlgNhvmmhwxDOTlW7Yy0IlGw?=
 =?us-ascii?Q?iby1HJOoa7XnccIgj0Xi0g47wUbs+KppteJ3S8NDR6m0fWUOqZ8AG8X5T/XG?=
 =?us-ascii?Q?fBuaQS3SnnV0De551VoSr+LfbCpJSfzQUvMK2fW2bMI8BqnnoV+pKTIOiIid?=
 =?us-ascii?Q?Hb10k5TKdqV1h/QdaaZwKQxuPXiSJdnDN7iYcVTYendzLRunjAtoyVvK0STm?=
 =?us-ascii?Q?A0MQedDRs7hWnC8i68JENAEfoSdEWaDYZ9YxRMV2nODqOQ3tMI1X1d47beH5?=
 =?us-ascii?Q?NdDQv7ugQpoAwDq0uGcOeBbgW4Am2J8NIkU4k1LMHIq0yfxrew5axRDR8xKK?=
 =?us-ascii?Q?FecZnwafrhtHx6KSMJzuE+yUxQVMz3gRZzkHW6Y0LH13JSJjnW6ZR6Pto69f?=
 =?us-ascii?Q?SjFlv2VKQ72n3Yq5vPdPl0Q7SP2rQrH8VbfNpA4bdlsVXHM0F7IDQZ3Fpyz2?=
 =?us-ascii?Q?zpwC6ATLv4Wpg1t+r1DRbGAATdfBJZZFBWILk4lPW2QOwES+VrlXEK5IyLef?=
 =?us-ascii?Q?pyxHSnEtanfDLal5JE1GGERXVRkUZEBiFeveHLXPevvrb8vcm0lsraW1muXR?=
 =?us-ascii?Q?Mz5ioS/6KcOuqPIwxz3218L30Q1PKt9VwME6QMb08oxva8ZU6QNUL1VRPSna?=
 =?us-ascii?Q?TTvcQID/UKCv4iOx98n6S+2/ReUsMuZ3YdBnX5DS1UtRUAgj/RLRxdafgrmp?=
 =?us-ascii?Q?+4GjJzYIvYrIeVD5VRx3sXMAX1uB6rBI3AUrTEXCYwqnugbSJeGqhFDdKqbs?=
 =?us-ascii?Q?bQ/2k2/zND/4zQYlqk5CsR+fBrHUGPUTyLyNmKfl8eljwMHl7eLTq5tKoR/C?=
 =?us-ascii?Q?dUE7P2h2xSQ6q6l5ozFxOLA0rs4o27pThxKW2VqDE7wvg4La9Ihw/9vTJY+n?=
 =?us-ascii?Q?oK0ntfD7R1Rxtobd67z9wUSGAcOxqHR334MLLZc8ny/r3W1COsQ9K3l7QgXv?=
 =?us-ascii?Q?xRbzNAScviyRn+//wEV/Emqnfsv5VtQ1TIWeVbAQ0Hz6uYqB8kPQnBscTtI+?=
 =?us-ascii?Q?5QHsYStwUgB0hJcdCAwkxzZpDPtUMVqZgcBHajro8IC74vMX58ZAYCiPIwS9?=
 =?us-ascii?Q?HCBcWETu+kE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUhY6WVmkrwwsu09pyQ+XJmjghljEZ9/hmECmmo+6rKiuHKM9oramaBeVR2w?=
 =?us-ascii?Q?dLDE3OUd3L/RWltgnJLPYxxNAdbprfAlJuZFm9Eg73j2ppKMrnTzYiQk/A3f?=
 =?us-ascii?Q?ifDGDaicS5udqhIiOQ+CIamsr1X1OiRQlUOO/CArpEnjE2993AvfMmXTD5Uo?=
 =?us-ascii?Q?l4reEtDyYaxukHxFi5lAo/npiB3g3UxDzMqRVpx3z5XKuvGv4wSID68D9t6p?=
 =?us-ascii?Q?sS2RUCzY6jOJnkRwG10tl0VEQc2LTimpY9f7rSYyh39kiIi0/epXQl6a+hNt?=
 =?us-ascii?Q?/J5IDZG0yi9JaKxDDcsVVriSgDhqT51FXmLCYTamZpgitwgpUrsCGAtHMjXr?=
 =?us-ascii?Q?+P0IsX83COrPxw3nfkT5ZKOafAOlx9PgldZPL64SqPvMnfsJRe+h6HPh/Ydh?=
 =?us-ascii?Q?D2zQWefQ0V67jGmv7fk4ViOD5DK3eW5fdARIXxK+K0Rs1uTIA4cuyubTRnpp?=
 =?us-ascii?Q?vjaLQe/SHUwSrd/EJa/F2I0wmjPJdqvYpTteks2REodwe/pt1JrzAOMhPkhd?=
 =?us-ascii?Q?OYDhmR+fgbl6sRSBGuO6alHnwTm1CzH5ROQCQK/kxqZOW/LuKaamP8Kargem?=
 =?us-ascii?Q?uHvmugN7ZuiWwAXjkF/lkCnUjnQieBdVKbvh8+gb9B6m4wll+iG2i5iOVaq5?=
 =?us-ascii?Q?WNWuIWZpxb2vhQ6RVwkAsCsexKIsVhPTXEtshJad8TSWQH5CelULbPkJPcSO?=
 =?us-ascii?Q?vjO2k+LljhfjOtJmwLwU7CZy05BHRECw7N7vG4cwYX7P+iKec01jv3Gbkm4o?=
 =?us-ascii?Q?y/f+2+/1tWg+GAx0UrCPey9Eg9cK+sBaEG+ArBN5Fu+jtEZmlU0H3eu8iqJU?=
 =?us-ascii?Q?lA+l8kC546iBgxzbJp1GJKlhJjdUFo/olaAUaEHKSejC2D0q5UrO9zHWP6yg?=
 =?us-ascii?Q?XoNMEVYZtTiDEhRqIYQL1K9etnMC9gTQuTrkJ+QwboZU28PBjBWxEs/Xqezt?=
 =?us-ascii?Q?sPj/3zYarU2Wx8N753cYjBHtS1kX3LZ5HO3t7gacI3YxN60xdo6Q8X5mEPfF?=
 =?us-ascii?Q?7v+yCHGPbjWZ/wFuQ48B2tAiuqvcslOopY1gwcW7s0kZLhieoD9BB34LfD1G?=
 =?us-ascii?Q?DR09zc/pHtHmA6Ep6il5eaG1weyYOq9aGjN7LlJbPhlpiF0OL0iC19EaOBPB?=
 =?us-ascii?Q?6r2NX/VCA6wJnAITCxyz+x9vJBNo0Sn7YP78N/nUzu9+RMzL3WEQLpJXTAXm?=
 =?us-ascii?Q?8D90fQCx3ClQdwD4BK6X4SxRWjal1EDnHQDA72e6HP/qHyR1Dg2/UTybM2Il?=
 =?us-ascii?Q?StFjW/mX63LpQ57Am8xd5GWfHaI8+MnwAzKQSWjDOiD7wPivYDS1yFM8M1uz?=
 =?us-ascii?Q?i+IIRgx8TbDVTYzOBd9zHdHDtkWc1JPz8nVj3iqPQ+xRsOetTR8bSZ1csAv7?=
 =?us-ascii?Q?3Kdvfarh3Cl9RXWNJCc8j5kAJhxSb9fJhQTMk66AxHH6wFqdqNE3qGP6PF+Y?=
 =?us-ascii?Q?neMRP6iT1bRpxpqMiVZ2jYhyPxPFIwJB4PEIA8xulP5D4jLVVb8NIaa+hSQA?=
 =?us-ascii?Q?V25HFrI0F9LCx3CK36+LikYpV08V4rDU1Xk1zify7w4UWzrCGqQqC4ct9YiP?=
 =?us-ascii?Q?qu16qxvjvBw5ByTKPcKsx0bNfvNxrUNpNx+sRX0C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436de7d8-51ef-49ac-f69a-08dde53dabd1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:45:19.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my1trgRcRIuDEmXYHrDZkbQ5fJrpwchcGEg5XcpfCFid9LuisG6L9tfZ4lKWq5+5m55nJ6Jpty2iFrILE2IRHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299

On Wed, Aug 27, 2025 at 12:01:09AM -0700, Eduard Zingerman wrote:
> On Tue, 2025-08-26 at 23:52 -0700, Eduard Zingerman wrote:
> 
> [...]
> 
> > If we are being really paranoid about LTO builds, is __noclone sufficient?
> > E.g. [1] does not imply that signature can't be changed.
> > We currently apply only __retain__, here is a little test with both attributes:
> 
> Nope, there are also 'used' and 'noinline' applied.
> With these the function is preserved as expected.
> Sorry for the noise.

Yeah, 'used' forces the function to be emitted even if it appears
unreferenced. Together with 'noclone', 'retain' and 'noinline', should
ensure the symbol exists and can be reliably found by resolve_btfids.

We could be extra paranoid and mimic EXPORT_SYMBOL(), moving the symbols to
their own section, but in practice I don't think this is strictly
necessary, even in presence of aggressive compiler / LTO optimizations.

Thanks,
-Andrea

