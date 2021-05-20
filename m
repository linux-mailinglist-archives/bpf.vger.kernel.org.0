Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7E389FC8
	for <lists+bpf@lfdr.de>; Thu, 20 May 2021 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhETI3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 04:29:23 -0400
Received: from mx0b-00007101.pphosted.com ([148.163.139.28]:45316 "EHLO
        mx0b-00007101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230102AbhETI3W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 May 2021 04:29:22 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2021 04:29:22 EDT
Received: from pps.filterd (m0166259.ppops.net [127.0.0.1])
        by mx0b-00007101.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K8Mq69010924;
        Thu, 20 May 2021 08:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=references :
 in-reply-to : from : date : message-id : subject : to : cc : content-type
 : content-transfer-encoding : mime-version; s=campusrelays;
 bh=1vPOD5/SmQsAgA03fHyImG1OAuwriWypWFoAzmvGm6I=;
 b=sPNwiFe6S8wsmQIxVY4LXrjMwLMd7xOh1Hizn+ZctPDGsa2piZ2uwdpFZwoZWkLxp3c/
 vOPPbtujJ3MSOjx6Uwr580BNcpUja1wBzDxPW+z/7odxxgesWtek32ZTNQ8czevptCp7
 nFyoZ1Z6e/kOxk/Pa2BHgCNj667xmJgYIRYi3qgMpBusajhwZ0JdP2oOxYDS7XEX0AvH
 c2BqeS1bgLiWQ4c+ciHVIH5tXEkz1V2M5pcGu+ryqXReB/mLWXI/0GtWSwtq5WjNKGuK
 rTPHAJZETNPm97X7iadUJyf2aOl42tir/VmfyHlGlJVypNlR19WVokxtJAhgfoYRUZRz WQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00007101.pphosted.com with ESMTP id 38n3w781f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 08:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQqHeavvrcNIk6ap+EPQumSzUIVt9lspEKAy9xQW7pkny6K+jJW3rvZY3W8Mf0OVg/XYj+jUS4V9Tzfy2ZcS3jveGfEevnCBEI15izJEWsuTV0FqV6cwfh9MmTmejmuGgUQS+wGGY+A5oVs0KCUFji8slyNyk1ZuHCDxp3kjdBG8FLO+XTsLL955gj3WM7W19IfE9M7bTK3fOtPfh0p0tG3Bq4oz5qxvfIackICuA0aVLCyu4kf3mhojNFXyGjbNkVoJldDUdFmFnh4h3x787Mci8YyEBL9TnftNZQFaLQazocyYhWfJRu3oat+CDE05y6qRxJuCmV/jbr4GIuPubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vPOD5/SmQsAgA03fHyImG1OAuwriWypWFoAzmvGm6I=;
 b=HUGB+BA9iPi7hjmZbOeGNIUc4T2o9nuWDQND07o1RQr9l0m9YakTJHDsEkT6aCbMFMMIXjhKC46fJ5xovD9qqFL6aAXK2MUMUr9st0RO6rkISJNGhoMAIeVPJM2/sClAcpE6SCsCSg1eTVDICOIZw2t6GbA+T8jwyvdY6MrbDhQPK/DvSeB9SZY9DJWB3ZHGekjNif7GXIfD4KKDYLgDjnBoxa8Q1U6vI5uYysGsUklKWJWjpVeV/rJ1jUS126WiEwMBWBikWyDbQcJR78p41RID47GWHXdHQAucTfOMCPOLPoEhWAzBt/gHlYI3C18njvlzelomYsqT05UV6IuNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=illinois.edu;
Received: from DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) by
 DM5PR11MB1436.namprd11.prod.outlook.com (2603:10b6:4:8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Thu, 20 May 2021 08:27:59 +0000
Received: from DM5PR11MB1692.namprd11.prod.outlook.com
 ([fe80::21bb:c117:6de2:2ac8]) by DM5PR11MB1692.namprd11.prod.outlook.com
 ([fe80::21bb:c117:6de2:2ac8%8]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 08:27:58 +0000
X-Gm-Message-State: AOAM530+zwn+1QLswY66Pm0E+e7XRoKl7mWrP3QG4eMyM9LaT5yClfF2
        gX3b1tATDcTJ4SBhdbbvrCHRN/+L2rDeLmgdB60=
X-Google-Smtp-Source: ABdhPJzYU8PPIuEKhtS+s4rdR95FWltc+cSLP5SJssuxJoJj622hGX0S886hCqXMZOEN4UXHj5aN0EnLbLZISELxyQ8=
X-Received: by 2002:a25:38ca:: with SMTP id f193mr5520847yba.422.1621498944674;
 Thu, 20 May 2021 01:22:24 -0700 (PDT)
References: <cover.1620499942.git.yifeifz2@illinois.edu> <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com> <eae2a0e5038b41c4af87edcb3d4cdc13@DM5PR11MB1692.namprd11.prod.outlook.com>
In-Reply-To: <eae2a0e5038b41c4af87edcb3d4cdc13@DM5PR11MB1692.namprd11.prod.outlook.com>
From:   Tianyin Xu <tyxu@illinois.edu>
Date:   Thu, 20 May 2021 03:22:13 -0500
X-Gmail-Original-Message-ID: <CAGMVDEFE8g5XKyQbB1xaK3ve58cENN2hZm3u=ktpGFgmBdQkeQ@mail.gmail.com>
Message-ID: <CAGMVDEFE8g5XKyQbB1xaK3ve58cENN2hZm3u=ktpGFgmBdQkeQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Andy Lutomirski <luto@kernel.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        bpf <bpf@vger.kernel.org>, "Zhu, YiFei" <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        "Jia, Jinghao" <jinghao7@illinois.edu>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [209.85.222.52]
X-ClientProxiedBy: BN7PR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:408:34::46) To DM5PR11MB1692.namprd11.prod.outlook.com
 (2603:10b6:3:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-ua1-f52.google.com (209.85.222.52) by BN7PR06CA0069.namprd06.prod.outlook.com (2603:10b6:408:34::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 08:27:58 +0000
Received: by mail-ua1-f52.google.com with SMTP id 20so5293281uaf.12;        Thu, 20 May 2021 01:27:58 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1b2fcb7-ea24-45a6-3a6a-08d91b692cd8
X-MS-TrafficTypeDiagnostic: DM5PR11MB1436:
X-Microsoft-Antispam-PRVS: <DM5PR11MB1436ABC3A3779B97F2D58E80BB2A9@DM5PR11MB1436.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RL5VlUJW4KvKJgg/HyjCZNWk/77FANmtkHYLgieUzeye1tMZUoHdP1ZoHtqcfQriUBIT6UVGDHwFJB+CafvEuVZGZA5q3AMiui58TEbXYg0Q5lAKJmAGrHroyiS5E6P5YizOmYbSEuqhtuCk6tGEvPgAcUrol2RJ52JhTuTBOc1VoEDKeGy+wK73wKwS2BS4Mu8Ic7xFIPIxTXZu1PSy9+2OZbb9+8/cvuCDYaHL+XaMkRw1KHxVMR6h8EFezFF78talp0wbbeY1g8CzKH42Rac1Y8M8HTsWYAgMRTXTaDNzkDCAgx3H9VBQpXoBhkJ0lN6842K8AYd/750xH0EX3ObY0FgLswvXHtXBXbiEUjKOcn3e9z7jxba9Y3iH+7Pw58yhMJeQEQYvohO0td0iH0wBrNbuIyz5jznqO8rq8FimJY12lz/HGVmX7ybzCkZx/dIjJL5hz0FYdMzVrTCo46BGS300EX2Myx0pOkvD25zORQYV7d5WvfCMVUTYctxgn3zV09XG9e0iNOBFuWErxKYordvHTq0OWW0qdRl8+HRuOE3OqUBnqdcP56AoC2EcJRKDTEjbLnF7WW0DosACpz8XQjoQwoAPgqjDZViidkzjCJqADZcsd0xbhWyXjNtDGL3nAY4KjX+/6QWTbPhoIMbClrTmaOI86zrEnFh60vRu9yyYnwZ4gu2+jUvuo1MnuAh6sdKC/WnMvDwld18dWUXLmm+eLhnIsQN4YQgoa+OC3OzV/CPjAf/s22Ui0X8xOk753cFVwvnn+n8Fw6gneg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39850400004)(66556008)(66476007)(26005)(75432002)(107886003)(66946007)(6666004)(52116002)(8676002)(83380400001)(53546011)(8936002)(6862004)(38350700002)(38100700002)(42186006)(966005)(186003)(9686003)(2906002)(786003)(54906003)(316002)(4326008)(86362001)(55446002)(450100002)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1crMFd0VEt0V3ZDU1lrcmVhZHhQNyt6aldOR21TeUJ2VmZvNW9lUDBTU1lC?=
 =?utf-8?B?bzNEdU5YUGluQ011Tlcxalkwd0hzZlo5Z203NWNLdDM2dlJqaVRXdFNkRFdm?=
 =?utf-8?B?cnJGVmJiWkZUZndaRzM1WDRDUWlQelRZOEdoS0dHRDZNdTg0T2NacS92NW12?=
 =?utf-8?B?OE5MZWxDNGdPSVBWZXIvekJLRFU0Z0FCb3VBWVBUZlpMcVJSRHVDM1FDNVpw?=
 =?utf-8?B?R1FOcHdDKzloM0dKRTIwMWM1cStEUWluUjBtQ1k0UjBRWmE5MTRJVFY4a3JS?=
 =?utf-8?B?UCs3cjd4YU9QdExZbDExTjVlOVJVbjVFRmZ5dVZoMWlhUzFJdkpoTExybktu?=
 =?utf-8?B?ckdySWFtanVRYWMyTGgvVEdUaUMzbnYwVDR1cGE4aXI1SjNFRWhXOUR3K1F4?=
 =?utf-8?B?K1FGa1A1ZE5TYjFMQUhjNS9TSlRuYm1zdFQ1WHk5M1FKSFU1SCtHb0haVnRp?=
 =?utf-8?B?dlg3cTRJWk5LYW83UWlLRndCNHhkVEhaNWtPZ3FjZG85Lyt1dWJNa2xSTExZ?=
 =?utf-8?B?N0N6Snd4RGhlandPR1hHOXM3T0wramtNTkdWRG9DdWFDaUVodTdwTm5Ga0Nr?=
 =?utf-8?B?MDd5TGFiSXFZazJoVEpEUDJ0QkYxM2x2bnNncjFLbi9sU3VkOHo4TFcyQ1di?=
 =?utf-8?B?WVFDRWNwS09Pemc3dWM5RnF2SXkxNEIvTUNYMVV1eFdBb2xtek04ekVuZDZ3?=
 =?utf-8?B?Z2FBWDQyd09MaGN0UC80WWlJMjZ1MkhabCtmSXFLcHEzMTFkamtuQ0pHdk9o?=
 =?utf-8?B?eU1WSUduckFhaTR0QUNKZDI2Smd0UVFOS2lTY01YbkFaa3N2T3ZFSERBOXVk?=
 =?utf-8?B?bG9oaUFoenhSU1RqampuS2hIWU54ZUNISG1jRVdzWW1TR1RIN2FoMXpRaVIr?=
 =?utf-8?B?dUwvOFJNZU90VFZkUkZXeng4UG5vSEVOSG1vYjlTYzBoVnhWaSt2SDZtTGlU?=
 =?utf-8?B?dFFia2FJWE1rdUYvUUc2c0RTVTcxcnZrMnFxbzR0MVpRQ0pxYThhV3J5OVBO?=
 =?utf-8?B?aUtza1MycmVVT1NWMDN5djhKejM0djFCeUxETTJ0MWtxU3JHajU0b01udjVa?=
 =?utf-8?B?cHQxTmwvQnhKMlBEbitvRmlpd1NUU0FMQ2xVQVczcUZVWnVpejAwY3lsWHhH?=
 =?utf-8?B?SHlibjVDVG9jVFJrNW9hTGNLYXo4blB4NUFrdmx3L1ZFamVRQjdMMnNLWVhh?=
 =?utf-8?B?Wlp0TW9NR05aa2pRcm1sU1RYVC9vMXBidVBKTFQ5cWo4aG5JVzE0eWhqaVdU?=
 =?utf-8?B?QUh3ZUNPV1llZWRKd1VoOUFUMDhhR2xkdVluQ3AwbnhRVkdNRTJWVC9GaTZU?=
 =?utf-8?B?aUNtck1rai91K01sL0RsK3ZxZVY4ZGsrL1BudXZpeVVrelcrcVRITGtxNXVk?=
 =?utf-8?B?ZzFRQy9Ra00zakVjaDd4alpzOURCWUZ4U2VyNlR4QWJtNk1pUTBGU2I4SG1z?=
 =?utf-8?B?RXU5RFpSU2RsYUc5dTdxU2FQUEJTZzBhNkxWZVlIQ1JJZ0l4R251THpiVEdS?=
 =?utf-8?B?U0R6M0FCc1JuMTRkWGNINktMWjF4ck9aNHJyay9QM3JNRWRBTFRLbUY3T1da?=
 =?utf-8?B?TkxoU1UvRGQ5UmRIeUMveTJuYkhmRkd6aFpJRGRqSmNFVTdpZTNvdnJSY1JQ?=
 =?utf-8?B?U3ZwYjN1Y2lWeFFsYndMb3VUTHpQMzF2dm01RE40MEx0S01KUlp5UHBpWmFI?=
 =?utf-8?B?Zlo5SE1aczVxYjdjcWJyN3VDeUJ3TGJPUGdySGlBb0wyQlpHakh0b2tRemM0?=
 =?utf-8?Q?7mTir3bVYQ3jMLAaIS9ZOj3BtVVEPKII8ZwG3vb?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b2fcb7-ea24-45a6-3a6a-08d91b692cd8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:27:58.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPqzbK4+X0cpQ+TjWmtc0OiOTmQKTYmfthaOtk5rsnV6elTokX8bjR1JkHTl8Kz9+UWsAQOIW8/iOdzKZHS/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1436
X-Proofpoint-GUID: u3Xtcs2Ic5Hb-0BK6TcziMS_zPNfpyzx
X-Proofpoint-ORIG-GUID: u3Xtcs2Ic5Hb-0BK6TcziMS_zPNfpyzx
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200063
X-Spam-Score: 0
X-Spam-OrigSender: tyxu@illinois.edu
X-Spam-Bar: 
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 17, 2021 at 12:08 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> On Sun, May 16, 2021 at 1:39 AM Tianyin Xu <tyxu@illinois.edu> wrote:
> >
> > On Sat, May 15, 2021 at 10:49 AM Andy Lutomirski <luto@kernel.org> wrot=
e:
> > >
> > > On 5/10/21 10:21 PM, YiFei Zhu wrote:
> > > > On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> =
wrote:
> > > >> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com=
> wrote:
> > > >>>
> > > >>> From: YiFei Zhu <yifeifz2@illinois.edu>
> > > >>>
> > > >>> Based on: https://urldefense.com/v3/__https://lists.linux-foundat=
ion.org/pipermail/containers/2018-February/038571.html__;!!DZ3fjg!thbAoRgmC=
eWjlv0qPDndNZW1j6Y2Kl_huVyUffr4wVbISf-aUiULaWHwkKJrNJyo$
> > > >>>
> > > >>> This patchset enables seccomp filters to be written in eBPF.
> > > >>> Supporting eBPF filters has been proposed a few times in the past=
.
> > > >>> The main concerns were (1) use cases and (2) security. We have
> > > >>> identified many use cases that can benefit from advanced eBPF
> > > >>> filters, such as:
> > > >>
> > > >> I haven't reviewed this carefully, but I think we need to distingu=
ish
> > > >> a few things:
> > > >>
> > > >> 1. Using the eBPF *language*.
> > > >>
> > > >> 2. Allowing the use of stateful / non-pure eBPF features.
> > > >>
> > > >> 3. Allowing the eBPF programs to read the target process' memory.
> > > >>
> > > >> I'm generally in favor of (1).  I'm not at all sure about (2), and=
 I'm
> > > >> even less convinced by (3).
> > > >>
> > > >>>
> > > >>>   * exec-only-once filter / apply filter after exec
> > > >>
> > > >> This is (2).  I'm not sure it's a good idea.
> > > >
> > > > The basic idea is that for a container runtime it may wait to execu=
te
> > > > a program in a container without that program being able to execve
> > > > another program, stopping any attack that involves loading another
> > > > binary. The container runtime can block any syscall but execve in t=
he
> > > > exec-ed process by using only cBPF.
> > > >
> > > > The use case is suggested by Andrea Arcangeli and Giuseppe Scrivano=
.
> > > > @Andrea and @Giuseppe, could you clarify more in case I missed
> > > > something?
> > >
> > > We've discussed having a notifier-using filter be able to replace its
> > > filter.  This would allow this and other use cases without any
> > > additional eBPF or cBPF code.
> > >
> >
> > A notifier is not always a solution (even ignoring its perf overhead).
> >
> > One problem, pointed out by Andrea Arcangeli, is that notifiers need
> > userspace daemons. So, it can hardly be used by daemonless container
> > engines like Podman.
> >
> > And, /* sorry for repeating.. */ the performance overhead of notifiers
> > is not close to ebpf, which prevents use cases that require native
> > performance.
>
> While I agree with you that this is the case right now, there's no reason=
 it
> has to be the case. There's a variety of mechanisms that can be employed
> to significantly speed up the performance of the notifier. For example, r=
ight
> now the notifier is behind one large per-filter lock. That could be remov=
ed
> allowing for better concurrency. There are a large number of mechanisms
> that scale O(n) with the outstanding notifications -- again, something
> that could be improved.

Thanks for the pointer! But, I don=E2=80=99t think this can fundamentally
eliminate the performance gap between the notifiers and the ebpf
filters. IMHO, the additional context switches of user notifiers make
the difference.

>
> The other big improvement that could be made is being able to use somethi=
ng
> like io_uring with the notifier interface, but it would require a
> fairly significant
> user API change -- and a move away from ioctl. I'm not sure if people are
> excited about that idea at the moment.
>

Apologize that I don=E2=80=99t fully understand your proposal. My
understanding about io_uring is that it allows you to amortize the
cost of context switch but not eliminate it, unless you are willing to
dedicate a core for it. I still believe that, even with io_uring, user
notifiers are going to be much slower than eBPF filters.

Btw, our patches are based on your patch set (thank you!). Are you
using user notifiers (with your improved version?) these days? It will
be nice to hear your opinions on ebpf filters.

> >
> >
> > > >> eBPF doesn't really have a privilege model yet.  There was a long =
and
> > > >> disappointing thread about this awhile back.
> > > >
> > > > The idea is that =E2=80=9Cseccomp-eBPF does not make life easier fo=
r an
> > > > adversary=E2=80=9D. Any attack an adversary could potentially utili=
ze
> > > > seccomp-eBPF, they can do the same with other eBPF features, i.e. i=
t
> > > > would be an issue with eBPF in general rather than specifically
> > > > seccomp=E2=80=99s use of eBPF.
> > > >
> > > > Here it is referring to the helpers goes to the base
> > > > bpf_base_func_proto if the caller is unprivileged (!bpf_capable ||
> > > > !perfmon_capable). In this case, if the adversary would utilize eBP=
F
> > > > helpers to perform an attack, they could do it via another
> > > > unprivileged prog type.
> > > >
> > > > That said, there are a few additional helpers this patchset is addi=
ng:
> > > > * get_current_uid_gid
> > > > * get_current_pid_tgid
> > > >   These two provide public information (are namespaces a concern?).=
 I
> > > > have no idea what kind of exploit it could add unless the adversary
> > > > somehow side-channels the task_struct? But in that case, how is the
> > > > reading of task_struct different from how the rest of the kernel is
> > > > reading task_struct?
> > >
> > > Yes, namespaces are a concern.  This idea got mostly shot down for kd=
bus
> > > (what ever happened to that?), and it likely has the same problems fo=
r
> > > seccomp.
> > >
> > > >>
> > > >> What is this for?
> > > >
> > > > Memory reading opens up lots of use cases. For example, logging wha=
t
> > > > files are being opened without imposing too much performance penalt=
y
> > > > from strace. Or as an accelerator for user notify emulation, where
> > > > syscalls can be rejected on a fast path if we know the memory conte=
nts
> > > > does not satisfy certain conditions that user notify will check.
> > > >
> > >
> > > This has all kinds of race conditions.
> > >
> > >
> > > I hate to be a party pooper, but this patchset is going to very high =
bar
> > > to acceptance.  Right now, seccomp has a couple of excellent properti=
es:
> > >
> > > First, while it has limited expressiveness, it is simple enough that =
the
> > > implementation can be easily understood and the scope for
> > > vulnerabilities that fall through the cracks of the seccomp sandbox
> > > model is low.  Compare this to Windows' low-integrity/high-integrity
> > > sandbox system: there is a never ending string of sandbox escapes due=
 to
> > > token misuse, unexpected things at various integrity levels, etc.
> > > Seccomp doesn't have tokens or integrity levels, and these bugs don't
> > > happen.
> > >
> > > Second, seccomp works, almost unchanged, in a completely unprivileged
> > > context.  The last time making eBPF work sensibly in a less- or
> > > -unprivileged context, the maintainers mostly rejected the idea of
> > > developing/debugging a permission model for maps, cleaning up the bpf
> > > object id system, etc.  You are going to have a very hard time
> > > convincing the seccomp maintainers to let any of these mechanism
> > > interact with seccomp until the underlying permission model is in pla=
ce.
> > >
> > > --Andy
> >
> > Thanks for pointing out the tradeoff between expressiveness vs. simplic=
ity.
> >
> > Note that we are _not_ proposing to replace cbpf, but propose to also
> > support ebpf filters. There certainly are use cases where cbpf is
> > sufficient, but there are also important use cases ebpf could make
> > life much easier.
> >
> > Most importantly, we strongly believe that ebpf filters can be
> > supported without reducing security.
> >
> > No worries about =E2=80=9Cparty pooping=E2=80=9D and we appreciate the =
feedback. We=E2=80=99d
> > love to hear concerns and collect feedback so we can address them to
> > hit that very high bar.
> >
> >
> > ~t
> >
> > --
> > Tianyin Xu
> > University of Illinois at Urbana-Champaign
> > https://urldefense.com/v3/__https://tianyin.github.io/__;!!DZ3fjg!o4__O=
b32oapUDg9_f6hzksoFiX9517CJ5-w8qtG9i-WKFs_xWbGQfUHpLjHjCddw$
