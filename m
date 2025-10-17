Return-Path: <bpf+bounces-71247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A82BEB529
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8E274851C
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1282F337B84;
	Fri, 17 Oct 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyXSfbAQ"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE05393DEE;
	Fri, 17 Oct 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727534; cv=fail; b=ELBR4SghXgpHUgTili/kli4Mr++C+41bJtuMcs9o0rogdrNRjvkqNgwEx8QzwSHtdCLRNAE/7ACBdUpwLUViZJ1Qtz/r4/8jdLXVqatBs8n8qkr7/EqJG5dsCh5lpv8IIF3LgzawDVlfMQVihC5o8A8IM0k3RQ0cHekWUdLSDnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727534; c=relaxed/simple;
	bh=b5ifY51Csu3bC/78LPGSIeNMdCTti9n94pLnpbd3SW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EK7T6JhfidMYgpakcLIoHDoMSA6svDzSo5i5Uav28bMNnbunhHdfcKxJOjUHdv3FeeIPns8fUf92Shiynl1bM7Nrr1N62PaDd1kaOFYavzYaikzR/Z8BQbD+MrxPogBU1tnxyqezgSV4llwDpTGqdm3u6RSKdlWkvGCz1WpR6eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyXSfbAQ; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC4DK82OJdbmZqsPzvShS5YqS7oiB58QMXruAGhB5ER/1kRVTq8CKa0fAoxc/E0tWlXzk1KE8eH06sIeMslLyPwplKmPjOeuzQH+4VTgh3ltO031AjdJ5+qqHIEkCJsW5zaJPaAQyg929zI+IwlaZujCvA1VjKPGgEoxlq9GFKkQwyZbVeZJHX9p0nE4hiyxI8JSOgY6/Q0DI4v0kSXb0KOv2ePg7QNZwHK5EtUOHn9nj3dCBhbVTjWam22GyOhDChm+H/tT6zIlbhRMyvNfFUbLiKlEzKCTu/kjBVrsRzAmZwnMW37ka18orOCiEQ+OR2KF8EwtLoVcaZNDwh9law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeEvyBBkY10C6mikXYb4qPgU1wnaC4ewYk9fRp0Hnbc=;
 b=a/5wbv/0TCiyQ4S37Hd6EKfmQBHxVMfRPXT2hd39cSZ9MSKho5rgImGriVzU1xOzpX3UxT50zTO4M2CjnRCF/ohvDGjG8m2vCYZwN4nXw/PYuBGYV3o1oazdVoFY93p9aSnns4atMXFe4Mw4tgD/4A4AawpQesBHUay82xsZmfB6mjTLrXDv4u2jczBVLmlwY0coFIjC8JnxlN9vNmGXRRYpLdPI02rq+Q9w3PzgXoYDFgEoDERmdZyF9rAtJ8H5q2wdw3DCYc397JZn8RRm90oXxyztwTQmKjJdA237BgCeTCGHpG2sQsjfsz2Ldauv9nlbNPeUKUdEPsdRalT7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeEvyBBkY10C6mikXYb4qPgU1wnaC4ewYk9fRp0Hnbc=;
 b=eyXSfbAQG5qsDm1JZWGlrQ9dPep6y7hDUj845TnZR6Ca9aorr7wMXMLVXqE2SE8JsXNcqYP7dw5r06xPUoef/x9c81369nqlzsk5YrLQ6Sssgg5kDTM7yBP25vk4K7faR7Lx2a9hExyxsbkroKf3gGwLS4hzUzE/UXYiZIVz6jbsCZ2SMkJWTpD/694SVyrCdXiDpi6Rg2NU1p0XTFT2w8ueeSNh6rdnShF107SEuR42pFV346z09pgscxbQaRRZSRS9xv+M/tJjMva9+VohJPHo8az0gle/fLimplsYiqnXpaSlNcI2bMasX+Xqg0z6nGhdKL14DTXqx7WIl/vXKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 18:58:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 18:58:48 +0000
Date: Fri, 17 Oct 2025 20:58:35 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPKR23mnuuUdmHhZ@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
 <aPJlIUF-KkdOdDvM@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJlIUF-KkdOdDvM@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c06130-9fdc-44d0-8352-08de0daf3456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?smHZKXku5oxfhB3nxiHtZshRxId3anhJg1PEkGvGOMNIgwcVKQ80s0FDb7l4?=
 =?us-ascii?Q?z8HVziNKJCKvfMwQ8gjgrOpIvxhFs2mgspedX0cdg/eGK+D7e91S8Nl9VjwQ?=
 =?us-ascii?Q?bWvxxHYcHMPTgz1tVUspb2TpjRaLSwQUjgPF95CWidFT2DeOwolZcjC7fg2e?=
 =?us-ascii?Q?x8Mp3zeBLcN5jPiASB+SxTaZ3xLnKLDkNZRkP4ECdzWBWLq7YR4gjKdTtt+t?=
 =?us-ascii?Q?2mUIi+qNoAZJBapTN7SBlh3jx4LnG3QWOjCdOnwAO7r3VLIW7/Nt6VFQCIr+?=
 =?us-ascii?Q?bh2XGOxoGXboMjQL/J7RT9nQEMRxcQveJB/lmz2x7xDWF6gmh14bMu+8T5xC?=
 =?us-ascii?Q?GYZTbjo3OO6NldhkF78FCSpW4YnwT1OV/wgwE6ZCc3Gxu0OkzBqo0DJALKQT?=
 =?us-ascii?Q?uXzDJ9UvBunO+N3lVcbVYQoXc9stakKD71uKjeQjG5eHtR6AYR3OWF/V82Tq?=
 =?us-ascii?Q?5Qzp1lWhiaXxXoszrnEUpdjE2uyXejx6JI0/odnIjZcasebRaeADCyE/C+mO?=
 =?us-ascii?Q?YcmH74whFYtBMgbz7l8aAgGPxOT2qqVxt/4O19VDgFx1rI3zVoIhe4chjkYR?=
 =?us-ascii?Q?9XCMfotNVpYyAxgzJH5Un1iLqu19O8IPpHnFGCAs0znuYYLlRU1cd0yqXTAv?=
 =?us-ascii?Q?jOAQ9IfucNkMeC7ftkUvpO4fuG7nWG773/JDmiGB8cdCAhIVhUbVvYNq2YoF?=
 =?us-ascii?Q?EEXlUY2kRCScJ1kSh1W5AjVFQY6rvgCoQScyXhlxmxeio1haXXEUS7XDmnpP?=
 =?us-ascii?Q?huDwQLJDAw9gkzkR6Dbx3VXabLuD08kiU3mZOSAQt6JJfB9cS2tYBhoDebiZ?=
 =?us-ascii?Q?56LTfSXCUEIMaZQPAZgOsSWKW4HYjQtFQ04KqMJV0xgzOEnXrPLEFVPaBEa9?=
 =?us-ascii?Q?3CdB56dgFSrt/nkee39CQyjIAbOlBnpUn196Paepv0xmMKquYc7yZExmu+th?=
 =?us-ascii?Q?5PI1SajVK6HdobOQUeh1E3RC29I8BW+DDWqyirFHQKSJH10BDAqCNjMQWIRU?=
 =?us-ascii?Q?pDHdyc3SnRb7/yRHOEVbNe38ec1WLMKpQPrhVxhm5KzQSyMc/s5R54v825I+?=
 =?us-ascii?Q?LYbAP0aM4UJr7qCvevYlsrtMGE30bgsjSNCM7ZfCsXHakMfm60AhPvEz3aWd?=
 =?us-ascii?Q?LmwJS4B7EiGt6lKsg4ytx7NcOT6so5jfTkDXmHoltrkpriQMWHiDifb7T+0s?=
 =?us-ascii?Q?/QI4bFb5wRm5uhEXbTTDtADKCKCIZHIG0ugPcG62Fuyc6hYsvyGZDumM2eSW?=
 =?us-ascii?Q?bMC3fpvJadFqiv4L11LXJQ2KKuyVNv+SOtM14F40pC/ymsLWdwcDdmRGFnTK?=
 =?us-ascii?Q?uv7mWA952IMgnZWf33Z+eGfHR1DJk0a+A8J5RuQW6/fq6U02bfuAydET0L9R?=
 =?us-ascii?Q?SoGIcJTLbir+B5F8NNKneael8CuWWVbWT2NM+ddg9zbg/3Gaw6Xp3vSseX3X?=
 =?us-ascii?Q?+9eFnsfgqH/ZRNmf6Ua9gOYjon3mr1bV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSiJgw/Y81EO0GU8jTEIK9T/yQylkkWIqagdLfB9Hc5UnwitgwEcpB63CAaM?=
 =?us-ascii?Q?i4bq9IJoRwD5ovqcjvWNUQgCZ1WHjZpLLxm/zCL+Eyxpv7/1+TQ98+v7U9vf?=
 =?us-ascii?Q?k5IGJ3mk1SC8NlJ9Ap3YXzGgtKphJYczs4Lc0qL5fbuZolbbRepHwtBbewDy?=
 =?us-ascii?Q?Uf2KCCmFLCCcnj6CZIVUTXBmfyY2gPkVkLBCcZ7TB6Uz+Jhx163rYXUTXuSn?=
 =?us-ascii?Q?spDXCqXFobByKhE4C4WCepda75AshlScfqETDLUMqwc8fPbIBxJVXOTF8AZd?=
 =?us-ascii?Q?oun3cKB/yZOrVHozC5GBCmxQKYu2R9kZZcKISJkVXwKXStXMusl8smh42OhX?=
 =?us-ascii?Q?/07/ukGYvxp7bc7KxL1oBIKXCskB2V5P5Fnrwwxj5hN1Ck3Re+CYX9UwlCI2?=
 =?us-ascii?Q?tP7kXjAMaBQniFDen+cU7Kz4HJU2fNxB1OZiOGMD8L4KiMF4fiuEsKZpB3iU?=
 =?us-ascii?Q?2J1gXqGWb+MsXPornhsMwtI7VDMNQ6/9hxXYAYS4Io3SdZWhKrpvtPRQW++n?=
 =?us-ascii?Q?lNRecmX5ZB2bLLggU+6W/8vFQKydyTRQKLsQZNk/RU/Q9Ri3ROZz4lTxsVqN?=
 =?us-ascii?Q?jxIIPeZcbIgafLEI2zcnECxli3UQNGv4dPxZJ0+2OvHEk0MLWQFxRUPnz2I4?=
 =?us-ascii?Q?OOKgKlU7Vf699cUdJzSgPmhf9QCk7TUdhFeSXY1UBDg0sSB7MoU0Ky7HL+eJ?=
 =?us-ascii?Q?7E5axZVvcpL4mnFB0xQA3+gSRKYmtFG5texR1R25vlAvFXKTY0qJo3kglEnp?=
 =?us-ascii?Q?IbAMMGnbISCIJko+4pi4coH6TCd7rvHfnkcWx1El/s/IbD0GrZHmc4W+guZX?=
 =?us-ascii?Q?MyYSQkFmxET9YFYYpAf/4jiexXe5KnHfHQqzWRdAJlxSXufZkGiWqRAdKItY?=
 =?us-ascii?Q?OVj/j0EFq6tU+7amHKs4t6z/0uYjPT50vcOL6ATnnzueCfbOguf3iKZHKrSr?=
 =?us-ascii?Q?crkR+5Q7jfdAWBbN0FRGUWJIv3iYn301umHD0UK8O1jPBQXf6n9kfAqUGXKA?=
 =?us-ascii?Q?Tj6NWuGpdtrgjQFl6OQkvixK61TRwICABcpXiGJSLKnOA0f9O3ZZYEHk9sOr?=
 =?us-ascii?Q?XjgcebCm77O65Zh6Db9FEaUq590hRMUd011Y2ifo73FRXqQce32Qn2mzLozx?=
 =?us-ascii?Q?aPzmLgDF8PE7YOwJi61kvFn/Mo0wCAjlpMffUrnLwvMNFljBFv8jB908T7mS?=
 =?us-ascii?Q?8OcYThStRKR+/ZHxVH/pdPb5TgxAbK74qkkAtT9r9jwGfPPj1NnGgvmo7UnW?=
 =?us-ascii?Q?olkD73XE9Mmj7JjIztgWcyQFwDdiw+3pbeC/YT3cTJqKvD09ul0ZUQxLWGe2?=
 =?us-ascii?Q?pHDpr3O1hK87YC9uLV/gxDdocyiqPihJX3cWVw/tZQYv7l1ASJ5fP5yUVqZ2?=
 =?us-ascii?Q?HGLTTeUpCF92xfA8fZUg36UvwrDiaLsAD2Di0zsf8zq0WnZItO+4XbPBTJpI?=
 =?us-ascii?Q?I95gAWhfhTL9FUn7pLynri73qRv1vy7WMSOSzZ0AFD3ENZY9qOM58Qs5Ur9G?=
 =?us-ascii?Q?LwzNo6TXIpRjDW9lUIUkOfrY23YiloUkiON+J7DP1P7YT78IYBnicRoeCvZl?=
 =?us-ascii?Q?OwcePtC2ycmomSL0NI8xALhC5H5zmkWabJkXgMZv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c06130-9fdc-44d0-8352-08de0daf3456
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 18:58:48.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ga3rPuwYpbxWJAwOS6LGEskA9G47vQiH5sjka5R6ojv2ZjvayPzSR9qbx1lTcCnjvLw6q4s52iWT6XZ/2CBhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573

On Fri, Oct 17, 2025 at 05:47:45AM -1000, Tejun Heo wrote:
> On Fri, Oct 17, 2025 at 11:25:53AM +0200, Andrea Righi wrote:
> > +static struct task_struct *
> > +ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > +{
> > +	return pick_task_scx(dl_se->rq, rf);
> > +}
> 
> I wonder whether we should tell pick_task_scx() to suppress the
> rq_modified_above() test in this case as a fair or RT task being enqueued
> has no reason to restart the picking process. While it will behave fine on
> retry, it's probably useful to be explicit here.

Yeah, that's a valid point. Maybe we can add a new flag to rq->scx.flags?
Something like SCX_RQ_DL_SERVER_PICK?

Thanks,
-Andrea

